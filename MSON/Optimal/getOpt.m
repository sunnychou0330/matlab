function [optimal, time]=getOpt(KH_profile)    
    load(KH_profile.datafile);
    NT = KH_profile.Tasks;
    NP = KH_profile.Providers;
    global bestQoS;
    global bestPath;
    global currentBest;
    bestPath = [];
    bestQoS = 99999999;
    currentBest = 9999999*ones(1, NT+1);
    
    path = [];
    
    tic;
    % back(services, path, 0, 1, NT, NP);
    bfs(services, 1, path, NT, NP)
    time = toc;
    
    optimal = bestQoS;
    % bestPath
    % bestQoS
    % currentBest
    clear global;
end


function bfs(services, task_index, path, NT, NP)
    if task_index > NT
        global bestQoS;
        fit = getFit(services, path);
        if fit < bestQoS
            bestQoS = fit;
            global bestPath;
            bestPath = path;
        end
        return;
    end

    global currentBest;
    for i=1:NP
        current_path = [path, i];
        qos = getFit(services, current_path);
        if currentBest(task_index) > qos
            currentBest(task_index) = qos;
            bfs(services, task_index+1, current_path, NT, NP)
        end
    end
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
