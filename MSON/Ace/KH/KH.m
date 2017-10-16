% NR       is number if Runs
% NK       is number if Krills
% MI .     is maximum Iteration
% C_flag   is crossover flag [Yes=1]
% N        is the motion induced by other krill individuals
% F        is the foraging motion
% D        is the physical diffusion of the ith krill individuals
% Vf       is the foraging speed
% Dmax     is the maximum diffusion speed
% Nmax     is the maximum induced speed
function result = KH(profile)

    %% setup
    NR       = profile.NR;
    NK       = profile.NK;
    MI       = profile.MI;
    CR       = profile.CR;
    Vf       = profile.Vf;
    Dmax     = profile.Dmax;
    Nmax     = profile.Nmax;
    datafile = profile.datafile;
    NT       = profile.Tasks;
    NP       = profile.Providers;
    load(datafile);

    % Bounds (Normalize search space in case of highly imbalanced search space)
    % NT = numel(services);
    % UB = []; LB = [];
    % for i=1:numel(services)
    %     UB = [UB; numel(services{i})];
    %     LB = [LB; 1];
    % end
    % UB = UB';
    % LB = LB';

    UB = NP*ones(1,NT);
    LB = ones(1,NT);

    % Scale Factor
    Dt = mean(abs(UB-LB))/2;
    F = zeros(NT,NK); D = zeros(1,NK); N = zeros(NT,NK); %R = zeros(NT,NK);
    ResponseTime = zeros(1, NR);

    %% Optimization & Simulation
    tic;
    for nr = 1:NR
        %Initial Krills positions
        for z1 = 1:NT
            X(z1,:) = LB(z1) + (UB(z1) - LB(z1)).*rand(1,NK);
        end

        for z2 = 1:NK
            [K(z2), responseTime]=fitness(X(:,z2), services, NT);
        end

        Kib=K;
        Xib=X;
        [Kgb(1,nr), A] = min(K);
        Xgb(:,1,nr) = X(:,A);
        

        for j = 1:MI 
            % Virtual Food
            for ll = 1:NT;
                Sf(ll) = (sum(X(ll,:)./K));
            end
            Xf(:,j) = Sf./(sum(1./K)); %Food Location       
            Xf(:,j) =findlimits(Xf(:,j)',LB,UB,Xgb(:,j,nr)');% Bounds Checking
            [Kf(j), responseTime] = fitness(Xf(:,j), services, NT);
            if 2<=j
                if Kf(j-1)<Kf(j)
                    Xf(:,j) = Xf(:,j-1);
                    Kf(j) = Kf(j-1);
                end
            end

            Kw_Kgb = max(K)-Kgb(j,nr);
            w = (0.1+0.8*(1-j/MI));

            for i = 1:NK
                % Calculation of distances
                Rf = Xf(:,j)-X(:,i);
                Rgb = Xgb(:,j,nr)-X(:,i);
                for ii = 1:NK
                    RR(:,ii) = X(:,ii)-X(:,i);
                end
                R = sqrt(sum(RR.*RR));

                % % % % % % % % % % % % % Movement Induced % % % % % % % % % %
                % Calculation of BEST KRILL effect
                if Kgb(j,nr) < K(i)
                    alpha_b = -2*(1+rand*(j/MI))*(Kgb(j,nr) - K(i)) /Kw_Kgb/ sqrt(sum(Rgb.*Rgb)) * Rgb;
                else
                    alpha_b=0;
                end

                % Calculation of NEIGHBORS KRILL effect
                nn=0;
                ds = mean(R)/5;
                alpha_n = 0;
                for n=1:NK
                    if and(R<ds,n~=i)
                        nn=nn+1;
                        if and(nn<=4,K(i)~=K(n))
                            alpha_n = alpha_n-(K(n) - K(i)) /Kw_Kgb/ R(n) * RR(:,n);
                        end
                    end
                end

                % Movement Induced
                N(:,i) = w*N(:,i)+Nmax*(alpha_b+alpha_n);

                % % % % % % % % % % % % % Foraging Motion % % % % % % % % % %
                % Calculation of FOOD attraction
                if Kf(j) < K(i)
                    Beta_f=-2*(1-j/MI)*(Kf(j) - K(i)) /Kw_Kgb/ sqrt(sum(Rf.*Rf)) * Rf;
                else
                    Beta_f=0;
                end

                % Calculation of BEST psition attraction
                Rib = Xib(:,i)-X(:,i);
                if Kib(i) < K(i)
                    Beta_b=-(Kib(i) - K(i)) /Kw_Kgb/ sqrt(sum(Rib.*Rib)) *Rib;
                else
                    Beta_b=0;
                end

                % Foraging Motion
                F(:,i) = w*F(:,i)+Vf*(Beta_b+Beta_f);

                % % % % % % % % % % % % % Physical Diffusion % % % % % % % % %
                % make more worse
                % D = Dmax*(1-j/MI)*floor(rand+(K(i)-Kgb(j,nr))/Kw_Kgb)*(2*rand(NT,1)-ones(NT,1));

                % % % % % % % % % % % % % Motion Process % % % % % % % % % % %
                DX = Dt*(N(:,i) + F(:,i));
                % DX = Dt*(N(:,i) + F(:,i) + D);

                % % % % % % % % % % % % % Crossover % % % % % % % % % % % % %
                % 100 % corssover procedure
                % C_rate = 0.8 + 0.2*(K(i)-Kgb(j,nr))/Kw_Kgb;
                C_rate = CR;
                Cr = rand(NT,1) < C_rate ;
                % Random selection of Krill No. for Crossover
                % NK4Cr = round(NK*rand+.5);
                % NK4Cr = rouletteWheelSelection(K, NK);
                % Crossover scheme
                % X(:,i)=X(:,NK4Cr).*(1-Cr)+X(:,i).*Cr;
                offspring = Xgb(:,j,nr).*(1-Cr)+X(:,i).*Cr;
                % offspring = Xgb(:,j,nr).*(1-Cr)+X(:,NK4Cr).*Cr;
                [offspring_fit, responseTime] = fitness(offspring, services, NT);
                
                % we improved KH algrithm to SKH, for more detiles see
                % Wang, G., Gandomi, A. H., & Alavi, A. H. (2013). Stud krill herd algorithm. *Neurocomputing*,
                if offspring_fit < K(i)
                    X(:,i) = offspring;
                else
                    % Update the position
                    X(:,i)=X(:,i)+DX;
                    X(:,i)=findlimits(X(:,i)',LB,UB,Xgb(:,j,nr)'); % Bounds Checking
                end            

                [K(i), responseTime] = fitness(X(:,i), services, NT);
                if K(i)<Kib(i)
                    Kib(i)=K(i);
                    Xib(:,i)=X(:,i);
                end         
            end

            % Update the current best
            [Kgb(j+1,nr), A] = min(K);
            
            if Kgb(j+1,nr) < Kgb(j,nr)
                Xgb(:,j+1,nr) = X(:,A);
                
                [useless, responseTime, providers] = fitness(X(:,A), services, NT);
                ResponseTime(nr) = responseTime;
                ProviderName(nr,:) = providers;
            else
                Kgb(j+1,nr) = Kgb(j,nr);
                Xgb(:,j+1,nr) = Xgb(:,j,nr);
                
                [useless, responseTime, providers] = fitness(Xgb(:,j,nr), services, NT);
                ResponseTime(nr) = responseTime;                
                ProviderName(nr,:) = providers;
            end
        end
    end
    time = toc/NR;

    %% return 
    Kgb(1,:) = [];    % remove first population
    [Best, Best_No] = min(Kgb(end,:));
    result.Best = Best;
    result.Mean = mean(Kgb(end,:));
    result.Worst = max(Kgb(end,:));
    result.Standard_Deviation = std(Kgb(end,:));
    result.Time = time;
    result.BestEvo = Kgb(:,Best_No);
    result.MeanEvo = mean(Kgb');
    result.ResponseTimeForEachRun = ResponseTime;
    % Xgb(:, j+1, nr) is the best solution for each run
    result.Solutions    = getSolutions(Xgb(:, j+1, :));
    result.ProviderName = ProviderName;
end

%% Evolutionary Boundary Constraint Handling Scheme
function [ns]=findlimits(ns,Lb,Ub,best)
    n=size(ns,1);
    for i=1:n
        ns_tmp = ns(i,:);
        I = ns_tmp < Lb;
        J = ns_tmp > Ub;
        A=rand;
        ns_tmp(I) = A*Lb(I) + (1-A)*best(I);
        B=rand;
        ns_tmp(J) = B*Ub(J) + (1-B)*best(J);
        ns(i,:) = ns_tmp;
    end
end

function index = rouletteWheelSelection(fitnesses, NK)
    s = sum(fitnesses);
    r = rand();
    agg = 0;
    index = round(NK*rand+.5);
    for i=1:NK
        agg = agg + fitnesses(i);
        if r > agg/s
            index = i;
            return;
        end
    end
end

function [f, rt, providers]=fitness(X, services, NT)
% Evolutionary Boundary Constraint Handling Scheme
%
%               t2                 t5(pi)
%      
%   t1   (p)           t4   (c)             t7        (t8         t9)       
%      
%               t3                 t6(pj)
%

    for i=1:NT
        ind = round(X(i));
        if ind <= 0
            ind = 1;
        end
        if isnan(ind)
            ind = 1;
        end
        index(i) = ind;
    end
    
    % all sequence
    rtn = 0; rt = 0; providers = [];
    for i=1:NT
        rtn = rtn + services{i}{index(i)}.rtn;
        rt  = rt + services{i}{index(i)}.rt;
        providers = [providers, services{i}{index(i)}.ProviderName];
    end
           
    % Response Time     Weight: 50%
    % Service Available Weight: 50%
    % f = 0.5 * rtn + 0.5 * (1 - ava);
    f = rtn/NT;
end

function S = getSolutions(S)
    [NT, useless, Runs] = size(S);
    for i=1:Runs
        X = S(:,:,i);
        for j=1:NT
        	X(j) = round(X(j));
            if X(j) <= 0
                X(j) = 1;
            end
            if isnan(X(j))
                X(j) = 1;
            end
        end
        S(:,:,i) = X;
    end
end

    