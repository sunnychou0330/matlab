function result = GA(profile)
load(profile.datafile);
inputs = services;
target = 0;
NT = profile.Tasks;
NP = profile.Providers;

% GA config
gaConfig = fsf.ga.Configuration();
gaConfig.Runs = profile.NR;
gaConfig.MaximumIterations = profile.MI;
gaConfig.PopulationSize = profile.PS;
gaConfig.PopulationType = 'random';
gaConfig.CrossoverRate = profile.CR;
gaConfig.MutationRate = profile.MR;

% GA operators
gaOps = fsf.ga.OperatorSet(...
                    fsf.ga.operators.selection.Random(), ...
                    MobileServiceComposition.features.Crossover(), ...
                    MobileServiceComposition.features.Mutation(), ...
                    fsf.ga.operators.replacement.Elitism());

% Factory to create individuals
% problem_dimensions = size(inputs, 2);
% UB = []; LB = [];
% for i=1:problem_dimensions
%     UB = [UB; numel(inputs{i})];
%     LB = [LB; 1];
% end
% UB = UB'; LB = LB';

UB = NP*ones(1,NT);
LB = ones(1,NT);

problem_dimensions = NT;


gaIndFactArgs = MobileServiceComposition.features.IndividualFactoryArgs(problem_dimensions, LB, UB);
gaIndFact = MobileServiceComposition.features.IndividualFactory(gaIndFactArgs);

% Fitness evaluator
gaFitEvaluator = MobileServiceComposition.features.FitnessEvaluator(inputs, target, NT);

ga = fsf.ga.GeneticAlgorithm(gaConfig, gaOps, gaFitEvaluator, gaIndFact);

% gaGUI = MobileServiceComposition.dummy_GUI();
% ga.addlistener('IterationEnds', @gaGUI.Plot);

tic;
[gaResult, Kgb] = ga.Execute();
time = toc/gaConfig.Runs;

%% return 
[Best, Best_No] = max(Kgb(end,:));
result.Best = Best;
result.Mean = mean(Kgb(end,:));
result.Worst = min(Kgb(end,:));
result.Standard_Deviation = std(Kgb(end,:));
result.Time = time;
result.BestEvo = Kgb(:,Best_No);
result.MeanEvo = mean(Kgb');
