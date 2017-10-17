clear all;
clc;

load('MIT.mat');


candidates = [];
time = 4;
NT = 24;
NP = 94;

for i=1:NP
    if m(time, i) == 1
        candidates = [candidates, i];
    end
end

fialure = 0;
res = [];

for i=1:100000
    test = round((rand(1, NT) + 0.5)* numel(candidates));
    for j=1:NT
        if m(time+1, test(j)) == 0
            res = [res, j];
            fialure = fialure + 1;
            break;
        end
    end
end

fialure
mean(res)
