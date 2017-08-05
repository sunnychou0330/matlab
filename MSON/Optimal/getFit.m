function getFit()
    load('Data/real-providers-100-tasks-100.mat');
    path = [4     4     4     1     4];   % 1.00596817815532
    % path = [4     4     5     7     5]; % 1.05481052119333
    % path = [8    10    10     6     5]; % 1.28743783094312
    % path = [4     4]; % 0.388568263539513
    % path = [8     10]; % 0.629909877141799
    % path = [1];  % 0.554441049685013
    % path = [2];  % 0.451704670620792
    % path = [3];  % 0.31390997089694
    % path = [4];  % 0.198112182940631
    % path = [5];  % 0.238007803051758
    % path = [6];  % 0.492592108251821
    % path = [7];  % 0.242390287463211
    % path = [8];  % 0.314617130612963
    % path = [4     1];  % 0.408240319831095
    
    rt   = 0;
    ava  = 1;
    for i=1:numel(path)
        rt = rt + services{i}{path(i)}.rt;
        ava = ava * services{i}{path(i)}.ava;
    end
    
    qos = 0.5 * rt + 0.5 * (1 - ava)
end