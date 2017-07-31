classdef Mutation < fsf.ga.operators.BaseMutation
    %MUTATION: Mutation for the feature selection problem
    
    
    methods(Access = protected)
        % Implements the mutation of an individual to generate mutated individual.
        % .-Swaps a feature selection flag in a single point
        %
        % @param individual: The individual to be mutated.
        %
        % @return mutatedIndividual: The individual result of mutation of the given one.
        
        function mutatedIndividual = MutationImplementation(this, individual)
            mutatedIndividual = individual;
            UB = individual.FactoryArgs.UB;
            LB = individual.FactoryArgs.LB;
            mutationPoint = (1+round((individual.FactoryArgs.Dimensions-1) * rand()));
            mutatedIndividual.Features(mutationPoint) = round(LB(mutationPoint) + (UB(mutationPoint) - LB(mutationPoint)).*rand(1));
        end
    end

end