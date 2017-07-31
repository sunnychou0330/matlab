classdef IndividualFactoryArgs < fsf.ga.IndividualFactoryArgs
    % INDIVIDUALFACTORYARGS Arguments need to create an individual

    properties
        Dimensions = 0; % Number of dimensions of the problem
        LB;             % Low bound of parameters
        UB;             % Up bound of parameters
    end
    
    methods
        function this = IndividualFactoryArgs(dimensions, LB, UB)
            % Creates a fsf.ga.IndividualFactoryArgs instance.
            %
            % @return this: The fsf.ga.IndividualFactoryArgs instance.
            
            this.Dimensions = dimensions;
            this.LB = LB;
            this.UB = UB;
        end
    end
end