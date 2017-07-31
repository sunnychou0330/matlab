classdef dummy_GUI < fsf.matlab.system.HiddenHandle
    properties(Access = private)
        Handle = NaN;
    end
    
    methods
        function Plot(this, src, data)
            % fitnesses = NaN(1, numel(data.AcumulatedResult.BestByIteration));
            % features = [];
            % for iIndividual = 1:numel(data.AcumulatedResult.BestByIteration)
            %     currentBest = data.AcumulatedResult.BestByIteration(iIndividual);
            %     fitnesses(iIndividual) = currentBest.Fitness.Value;
            %     features = [features; currentBest.Features];
            % end
            
            fitnesses = data.AcumulatedResult.Best.Fitness.Value;
            fprintf('Current best: %d \n\n ', fitnesses);
            % if(isequaln(this.Handle, NaN))
            %     this.Handle = figure;
            % end
            % figure(this.Handle);
            
            % plot(fitnesses);
            % xlim([0, src.Configuration.MaximumIterations]);
        end
    end
end
