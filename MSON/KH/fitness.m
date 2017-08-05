function f=fitness(X, services, NT)
% Evolutionary Boundary Constraint Handling Scheme
%
%               t2                 t5(pi)
%      
%   t1   (p)           t4   (c)             t7        (t8         t9)       
%      
%               t3                 t6(pj)
%

    for i=1:NT
        ind = round(X(i));
        if ind == 0
            ind = 1;
        end
        index(i) = ind;
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









function f=fitness2(X, services, NT)
% Evolutionary Boundary Constraint Handling Scheme
%
%               t2                 t5(pi)
%      
%   t1   (p)           t4   (c)             t7        (t8         t9)       
%      
%               t3                 t6(pj)
%

    for i=1:NT
        ind = round(X(i));
        if ind == 0
            ind = 1;
        end
        index(i) = ind;
    end

    s1  = services{1}{index(1)};
    s2  = services{2}{index(2)};
    s3  = services{3}{index(3)};
    s4  = services{4}{index(4)};
    s5  = services{5}{index(5)};
    s6  = services{6}{index(6)};
    s7  = services{7}{index(7)};

    % parallel
    if s2.rt > s3.rt
        p = s2.rt;
    else
        p = s3.rt;
    end
    % choice
    c = 0.5 * s5.rt + 0.5 * s6.rt;

    rt  = s1.rt + p + s4.rt + c + s7.rt;
    ava = s1.ava * s2.ava * s3.ava * s4.ava * (0.5*s5.ava + 0.5*s6.ava) * s7.ava;

    for i=8:NT
        rt  = rt + services{i}{index(i)}.rt;
        ava = ava * services{i}{index(i)}.ava;
    end
    
    % qos = ava / rt; positive
    
    f = rt + NT * ava;
end