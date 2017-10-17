clear all;
clc;

load('MIT.mat');


candidates = [];
time = 1;
NT = 24;
NP = 94;

for i=1:NP
    if m(time, i) == 1
        candidates = [candidates, i];
    end
end

fialure = 0;
res = [];
for k=1:100000
    test = round((rand(1, NT) + 0.5)* numel(candidates));

    for i=1:8   % this 8 means eight time points
        flag = 0;
        for j=1:NT
            if m(time+i-1, test(j)) == 0
                fialure = fialure + 1;
                res = [res, j];
                flag = 1;
                break;
            end
        end
        if flag
            break;
        end
    end
end

fialure
numel(res)
mean(res)
