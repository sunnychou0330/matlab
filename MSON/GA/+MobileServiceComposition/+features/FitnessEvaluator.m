classdef FitnessEvaluator < fsf.ga.FitnessEvaluator
    %FITNESSEVALUATOR Fitness evaluator for the feature selection problem
    %   .- Measures the MSE of the method in the inputs with respect to the target
    
    properties
        Inputs; % Inputs of the problem
        Target; % Target of the problem
        NT;     % Numbers of Tasks;
        NumChannels; % Number of channels (variables) of the problem
        NumMeasures; % Number of measures (samples) of the problem
    end
    
    methods
        function this = FitnessEvaluator(inputs, target, NT)
            % Creates a sample.features.FitnessEvaluator instance.
            %
            % @param inputs: The inputs of the regression problem.
            % @param target: The target of the regression problem.
            %
            % @return this: The sample.features.FitnessEvaluator instance.

            this@fsf.ga.FitnessEvaluator('lower_best');
            this.Inputs = inputs;
            this.Target = target;
            this.NT = NT;
            [this.NumMeasures, this.NumChannels] = size(inputs);
            % this.problem_dimensions = size(inputs, 2);
        end 
    end
    
    methods(Access = public)
        function fitness = EvaluateIndividual(this, theIndividual)
            % Evaluates the fitness of an individual
            %
            % @param individual: The individual to whom the fitness will be evaluated.
            %
            % @return fitness: The fitness of the individual.
            
            % if(this.NumChannels ~= (theIndividual.FactoryArgs.Dimensions))
            %    error('Matrix dimensions and individual feature selector size do not match');
            % end

            features = theIndividual.Features;
            services = this.Inputs;
            % all sequence
            rt = 0; ava = 1;
            for i=1:this.NT
                rt  = rt + services{i}{features(i)}.rt;
                ava = ava * services{i}{features(i)}.ava;
            end
            
            % qos = ava / rt; positive
            f = 0.5 * rt + 0.5 * (1 - ava);
            fitness = fsf.ga.Fitness(f);
        end
    end    
end