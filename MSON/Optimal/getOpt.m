function [optimal, time]=getOpt(KH_profile)    
    load(KH_profile.datafile);
    NT = KH_profile.Tasks;
    NP = KH_profile.Providers;
    global bestQoS;
    global bestRt;
    global bestPath;
    global currentBest;
    bestPath = '';
    bestQoS = 0;
    bestRt = 0;
    currentBest = zeros(1,NT);
    global services;
    tic;
    back(1, 0, 0, 'path: ', NT, NP);
    time = toc;
    optimal = bestQoS;
    % bestPath
    % bestQoS
    % bestRt
    % currentBest;
    clear global;
end

function back(task_index, current_qos, current_rt, path, NT, NP)  
    global services;
    global currentBest;
    
    if task_index ~= 1
        if currentBest(task_index-1) == 0
            currentBest(task_index-1) = current_qos;
        else
            if currentBest(task_index-1) < current_qos
                currentBest(task_index-1) = current_qos;
            else
                return;
            end
        end
    end
    
    if task_index > NT        
        global bestQoS;
        global bestRt;
        global bestPath;
        if current_qos > bestQoS
            bestQoS  = current_qos;
            bestPath = path;
            bestRt   = current_rt;
        end
        return;
    end
    
    for i=1:NP
        current_qos = current_qos + services{task_index}{i}.qos;
        current_rt  = current_rt + services{task_index}{i}.rt;
        if current_rt > 1000
            return;
        end
        back(task_index + 1, current_qos, current_rt, [path, ' ', num2str(i)], NT, NP);
        current_qos = current_qos - services{task_index}{i}.qos;
        current_rt  = current_rt - services{task_index}{i}.rt;
    end
end