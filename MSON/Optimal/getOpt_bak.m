function [opt, rt] = getOpt(datafile)
    load(datafile);
    opt = 0;
    rt  = 0;

    for i=1:numel(services)
        max = 0;
        index = 0;
        for j=1:numel(services{i})
            if services{i}{j}.qos > max
                max = services{i}{j}.qos;
                index = j;
            end
        end
        opt = opt + max;
        rt  = rt + services{i}{index}.rt;
    end
end
