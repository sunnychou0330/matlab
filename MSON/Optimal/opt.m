load('providers-100-tasks-50.mat');

NP = numel(t);
res = 0;
for i=1:NP
    NT = numel(t{i});
    max = 0;
    for j=1:NT
        if t{i}{j}.qos > max
            max = t{i}{j}.qos;
        end
    end
    res = res + max;
end

res
