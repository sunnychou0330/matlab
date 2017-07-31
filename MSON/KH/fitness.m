function f=fitness(X, t)
% Evolutionary Boundary Constraint Handling Scheme
NP = numel(t);
agg = 0;
for i=1:NP
    index = round(X(i));
    if index == 0
        index = 1;
    end
    agg = agg + t{i}{index}.qos;
end
f = 1 / agg;