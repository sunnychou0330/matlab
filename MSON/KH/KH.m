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
NR = profile.NR;
NK = profile.NK;
MI = profile.MI;
C_flag  = profile.C_flag;
Vf = profile.Vf;
Dmax = profile.Dmax;
Nmax = profile.Nmax;
datafile = profile.datafile;

load(datafile);
NP = numel(services); % Number of Parameter(s)

% Bounds (Normalize search space in case of highly imbalanced search space)
UB = []; LB = [];
for i=1:NP
    UB = [UB; numel(services{i})];
    LB = [LB; 1];
end

UB = UB';
LB = LB';

% Scale Factor
Dt = mean(abs(UB-LB))/2;
F = zeros(NP,NK); D = zeros(1,NK); N = zeros(NP,NK); %R = zeros(NP,NK);

%% Optimization & Simulation
tic;
for nr = 1:NR
    %Initial Krills positions
    for z1 = 1:NP
        X(z1,:) = LB(z1) + (UB(z1) - LB(z1)).*rand(1,NK);
    end
    
    for z2 = 1:NK
        K(z2)=fitness(X(:,z2), services);
    end
    
    Kib=K;
    Xib=X;
    [Kgb(1,nr), A] = min(K);
    Xgb(:,1,nr) = X(:,A);
    
    for j = 1:MI 
        % Virtual Food
        for ll = 1:NP;
            Sf(ll) = (sum(X(ll,:)./K));
        end
        Xf(:,j) = Sf./(sum(1./K)); %Food Location       
        Xf(:,j) =findlimits(Xf(:,j)',LB,UB,Xgb(:,j,nr)');% Bounds Checking
        Kf(j) = fitness(Xf(:,j), services);
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
            D = Dmax*(1-j/MI)*floor(rand+(K(i)-Kgb(j,nr))/Kw_Kgb)*(2*rand(NP,1)-ones(NP,1));
            
            % % % % % % % % % % % % % Motion Process % % % % % % % % % % %
            DX = Dt*(N(:,i)+F(:,i));           
             
            % % % % % % % % % % % % % Crossover % % % % % % % % % % % % %
            if C_flag ==1
                C_rate = 0.8 + 0.2*(K(i)-Kgb(j,nr))/Kw_Kgb;
                Cr = rand(NP,1) < C_rate ;
                % Random selection of Krill No. for Crossover
                NK4Cr = round(NK*rand+.5);  
                % Crossover scheme
                X(:,i)=X(:,NK4Cr).*(1-Cr)+X(:,i).*Cr;
            end
            
            % Update the position
            X(:,i)=X(:,i)+DX;
            X(:,i)=findlimits(X(:,i)',LB,UB,Xgb(:,j,nr)'); % Bounds Checking

            K(i)=fitness(X(:,i), services);
            if K(i)<Kib(i)
                Kib(i)=K(i);
                Xib(:,i)=X(:,i);
            end         
        end
        
        % Update the current best
        [Kgb(j+1,nr), A] = min(K);
        if Kgb(j+1,nr)<Kgb(j,nr)
            Xgb(:,j+1,nr) = X(:,A);
        else
            Kgb(j+1,nr) = Kgb(j,nr);
            Xgb(:,j+1,nr) = Xgb(:,j,nr);
        end
    end
end
time = [num2str(toc/NR), ' s'];

%% return 
[Best, Best_No] = min(Kgb(end,:));
result.Best = 1/Best;
result.Mean = mean(Kgb(end,:));
result.Worst = 1/max(Kgb(end,:));
result.Standard_Deviation = std(Kgb(end,:));
result.Time = time;
result.BestEvo = 1./Kgb(:,Best_No);
result.MeanEvo = 1./mean(Kgb');

%% Evolutionary Boundary Constraint Handling Scheme
function [ns]=findlimits(ns,Lb,Ub,best)

n=size(ns,1);
for i=1:n
    ns_tmp=ns(i,:);
    I=ns_tmp<Lb;
    J=ns_tmp>Ub;
    A=rand;
    ns_tmp(I)=A*Lb(I)+(1-A)*best(I);
    B=rand;
    ns_tmp(J)=B*Ub(J)+(1-B)*best(J);
  ns(i,:)=ns_tmp;
end