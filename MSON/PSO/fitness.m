function f=fitness(X, services, NT)
	for i=1:NT
        index(i) = round(X(i));
    end
    
    % all sequence
    rt = 0; ava = 1;
    for i=1:NT
        rt  = rt + services{i}{index(i)}.rt;
        ava = ava * services{i}{index(i)}.ava;
    end
    
    % qos = ava / rt; positive
    f = 0.5 * rt + 0.5 * (1 - ava);
    
    %f = rt / ava;
end
