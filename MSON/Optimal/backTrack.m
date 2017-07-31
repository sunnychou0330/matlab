function [optimal, time]=backTrack(datafile)
    load(datafile);
    global bestQoS;
    global bestRt;
    global bestPath;
    global currentBest;
    bestPath = '';
    bestQoS = 0;
    bestRt = 0;
    currentBest = zeros(1,15);
    global services;
    tic;
    back(1, 0, 0, 'path: ');
    time = toc;
    optimal = bestQoS;
    % bestPath
    % bestQoS
    % bestRt
    % currentBest;
end

function back(task_index, current_qos, current_rt, path)  
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
    
    if task_index > 15        
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
    
    for i=1:20
        current_qos = current_qos + services{task_index}{i}.qos;
        current_rt  = current_rt + services{task_index}{i}.rt;
        if current_rt > 100
            return;
        end
        back(task_index + 1, current_qos, current_rt, [path, ' ', num2str(i)]);
        current_qos = current_qos - services{task_index}{i}.qos;
        current_rt  = current_rt - services{task_index}{i}.rt;
    end
end