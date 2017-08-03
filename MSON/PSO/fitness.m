function f=fitness(X, services, NT)
% Evolutionary Boundary Constraint Handling Scheme
agg = 0;
for i=1:NT
    index = round(X(i));
    agg = agg + services{i}{index}.qos;
end
f = 1 / agg;