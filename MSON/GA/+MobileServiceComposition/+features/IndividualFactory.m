classdef IndividualFactory < fsf.ga.IndividualFactory
    %INDIVIDUALFACTORY Implements how the individuals of a population are created
    
    methods
        function this = IndividualFactory(individualFactoryArgs)
            % Creates a fsf.ga.IndividualFactory instance.
            %
            % @param factoryArgs: the fsf.ga.IndividualFactoryArgs parametrizing how the individuals are created.
            %
            % @return this: The fsf.ga.IndividualFactory instance.

            this@fsf.ga.IndividualFactory(individualFactoryArgs);
        end 
    end
    
    methods(Access = public)
        function individual = CreateRandomIndividual(this)
            % Factory method to creates an individual randomly.
            %
            % @return individual: The randomly created individual.

            individual = MobileServiceComposition.features.Individual(this.FactoryArgs);
            LB = this.FactoryArgs.LB;
            UB = this.FactoryArgs.UB;
            
            features = [];
            for i=1:this.FactoryArgs.Dimensions
                features = [features; round(LB(i) + (UB(i) - LB(i)).*rand(1))];
            end
            individual.Features = features';
            % individual.Features = logical(round(rand(1, this.FactoryArgs.Dimensions)));
        end
    end
    
    methods(Access = protected)
        function population = CreateCustomPopulation(this, thePopulationSize)
            % Factory method to creates a custom population (no random individuals).
            %
            % @param populationSize: The size of the population to be created customly.
            %
            % @return population: The created population composed of custom individuals.
            %
            % Remarks: When no implementation is provided, an error is raised.
                    
            % TODO: Creates your custom population here if you have information of the problem
            population = CreateCustomPopulation@fsf.ga.IndividualFactory(this, thePopulationSize);
        end
        
    end
    
end