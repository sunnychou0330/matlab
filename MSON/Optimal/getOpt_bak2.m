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
    tic;
    back(services, 1, 0, 0, 1, 'path: ', NT, NP);
    time = toc;
    optimal = bestQoS;
    % bestPath
    % bestQoS
    % bestRt
    % currentBest;
    clear global;
end

function back(services, task_index, current_qos, current_rt, current_ava, path, NT, NP)      
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
        current_ava_bak = current_ava; current_rt_bak = current_rt; current_qos_bak = current_qos;
        current_ava = current_ava * services{task_index}{i}.ava; 
        current_rt  = current_rt + services{task_index}{i}.rt;
        current_qos = current_qos + (current_ava * NT) + current_rt;
        if current_rt > 1000
            return;
        end
        back(services, task_index + 1, current_qos, current_rt, current_ava, [path, ' ', num2str(i)], NT, NP);
        current_qos  = current_qos_bak;
        current_rt   = current_rt_bak;
        current_ava  = current_ava_bak;
    end
end