%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA102
% Project Title: Implementation of Particle Swarm Optimization in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function result = PSO(profile)
    datafile = profile.datafile;
    load(datafile);

    NT = profile.Tasks;
    NP = profile.Providers;

    nVar = NT;           % Number of Decision Variables

    VarSize=[1 nVar];              % Size of Decision Variables Matrix

    VarMin = 0;                % Lower Bound of Variables
    VarMax = NP;         % Upper Bound of Variables

    % UB = []; LB = [];
    % for i=1:nVar
    %     UB = [UB; numel(services{i})];
    %     LB = [LB; 1];
    % end

    % UB = UB';
    % LB = LB';

    UB = NP*ones(1,NT);
    LB = ones(1,NT);

    %% PSO Parameters

    MaxIt=profile.MI;      % Maximum Number of Iterations

    nPop=profile.PS;        % Population Size (Swarm Size)

    % PSO Parameters
    w = profile.Weight;            % Inertia Weight
    wdamp=0.99;     % Inertia Weight Damping Ratio
    c1 = profile.C1;         % Personal Learning Coefficient
    c2 = profile.C2;         % Global Learning Coefficient

    % If you would like to use Constriction Coefficients for PSO,
    % uncomment the following block and comment the above set of parameters.

    % % Constriction Coefficients
    % phi1=2.05;
    % phi2=2.05;
    % phi=phi1+phi2;
    % chi=2/(phi-2+sqrt(phi^2-4*phi));
    % w=chi;          % Inertia Weight
    % wdamp=1;        % Inertia Weight Damping Ratio
    % c1=chi*phi1;    % Personal Learning Coefficient
    % c2=chi*phi2;    % Global Learning Coefficient

    % Velocity Limits
    VelMax=0.1*(VarMax-VarMin);
    VelMin=-VelMax;

    Kgb = zeros(profile.MI, profile.NR);
    tic;
    %% PSO Main Loop
    for j=1:profile.NR
        % Initialization
        empty_particle.Position=[];
        empty_particle.Cost=[];
        empty_particle.Velocity=[];
        empty_particle.Best.Position=[];
        empty_particle.Best.Cost=[];

        particle=repmat(empty_particle,nPop,1);
        GlobalBest.Cost=inf;
        BestCost=zeros(MaxIt,1);
        
        for i=1:nPop
            % Initialize Position
            % particle(i).Position = unifrnd(VarMin,VarMax,VarSize);
            position = [];
            for ii=1:nVar
                position = [position round(LB(ii) + (UB(ii) - LB(ii)).*rand(1))];
            end
            particle(i).Position = position;

            % Initialize Velocity
            particle(i).Velocity = zeros(VarSize);

            % Evaluation
            particle(i).Cost = fitness(particle(i).Position, services, NT);

            % Update Personal Best
            particle(i).Best.Position = particle(i).Position;
            particle(i).Best.Cost = particle(i).Cost;

            % Update Global Best
            if particle(i).Best.Cost<GlobalBest.Cost
                GlobalBest=particle(i).Best;
            end
        end
        
        for it=1:MaxIt
            for i=1:nPop

                % Update Velocity
                particle(i).Velocity = w*particle(i).Velocity ...
                    +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
                    +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);

                % Apply Velocity Limits
                particle(i).Velocity = max(particle(i).Velocity,VelMin);
                particle(i).Velocity = min(particle(i).Velocity,VelMax);

                % Update Position
                particle(i).Position = particle(i).Position + particle(i).Velocity;

                % Velocity Mirror Effect
                IsOutside=(particle(i).Position<VarMin | particle(i).Position>VarMax);
                particle(i).Velocity(IsOutside)=-particle(i).Velocity(IsOutside);

                % Apply Position Limits
                particle(i).Position = max(particle(i).Position,VarMin);
                particle(i).Position = min(particle(i).Position,VarMax);

                % Evaluation
                particle(i).Cost = fitness(particle(i).Position, services, NT);

                % Update Personal Best
                if particle(i).Cost<particle(i).Best.Cost

                    particle(i).Best.Position=particle(i).Position;
                    particle(i).Best.Cost=particle(i).Cost;

                    % Update Global Best
                    if particle(i).Best.Cost<GlobalBest.Cost

                        GlobalBest=particle(i).Best;

                    end

                end

            end

            BestCost(it) = GlobalBest.Cost;            
            % disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(1/BestCost(it))]);
            w=w*wdamp;
        end
        Kgb(:, j) = BestCost;
    end
    time = toc/profile.NR;
    BestSol = 1/GlobalBest.Cost;


    %% Results
    [Best, Best_No] = min(Kgb(end,:));
    result.Best = 1/Best;
    result.Mean = 1/mean(Kgb(end,:));
    result.Worst = 1/max(Kgb(end,:));
    result.Standard_Deviation = std(Kgb(end,:));
    result.Time = time;
    result.BestEvo = 1./Kgb(:,Best_No);
    result.MeanEvo = 1./mean(Kgb');

    %% figure;
    % plot(BestCost,'LineWidth',2);
    % semilogy(1./BestCost,'LineWidth',2);
    % xlabel('Iteration');
    % ylabel('Best Cost');
    % grid on;
end
