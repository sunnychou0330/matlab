function [opt, rt] = getOpt(datafile)
    load(datafile);
    global services;

    NP = numel(services);
    opt = 0;
    rt  = 0;

    for i=1:NP
        NT = numel(services{i});
        max = 0;
        index = 0;
        for j=1:NT
            if services{i}{j}.qos > max
                max = services{i}{j}.qos;
                index = j;
            end
        end
        opt = opt + max;
        rt  = rt + services{i}{index}.rt;
    end
    opt
    rt
end



function [rt, qos]=itr(task_index, provider_index, current_rt, current_qos, path)
    path
    global services;
    
    if task_index == 15
        rt  = services{task_index}{provider_index}.rt;
        qos = services{task_index}{provider_index}.qos;
        return;
    end
    
    if task_index == 0
        rt_p = 0; qos_p = 0;
    else        
        rt_p  = current_rt + services{task_index}{provider_index}.rt;
        qos_p = current_qos + services{task_index}{provider_index}.qos;
    end
    
    rt = 0; qos = 0;
    for i=1:20
        [rt_t, qos_t] = itr(task_index + 1, i, rt_p, qos_p, [path, ' ', num2str(i)]);
        if qos_t > qos
            qos = qos_t; rt = rt_t;
        end
    end    
end