function getOptTest()
    clear; clc;
    load('Data/real-providers-100-tasks-100.mat');
    
    NP = 10;
    
    best = 99999999;
    tic;
    for a=1:NP
        for b=1:NP
            for c=1:NP
                for d=1:NP
                    for e=1:NP
                        path = [a, b, c, d, e]
                        f = getFit(services, path);
                        if f < best
                            best = f;
                        end
                    end
                end
            end
        end
    end
    toc
    
    best
end



function qos = getFit(services, path)
    rt   = 0;
    ava  = 1;
    for i=1:numel(path)
        rt = rt + services{i}{path(i)}.rt;
        ava = ava * services{i}{path(i)}.ava;
    end
    
    qos = 0.5 * rt + 0.5 * (1 - ava);
end
