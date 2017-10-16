function DataGen(t)     
    data = load('RealDataSet.mat');
    mit  = load('Mit.mat');
    data = data.DataSet;
    mit  = mit.m;

    time   = t;        % Time Point
    timeUp = 8;
    NP     = 30;      % Number of mobile service provider
    NT     = 25;       % Number of Tasks
    TP     = 0;        % Probability of service
    
    % round(rand(1, 25) * 950)
    services = [659   898   745   670   104   370   561   436    48   217   792    15   821    74   636   475   207 543   116   638   570    53    54   145    19];
    
    for i=1:NT        
        CandidateService(i,:) = data{services(i)};
    end

    providers = [];


    for i=1:NP
        if mit(time, i) == 1
            provider = struct('ProviderName', i);
            
            ava = calcAva(mit, time, timeUp, i);

            for j=1:NT
                if rand() > TP
                    q = CandidateService(j).QoS;
                    index  = ceil(rand(1) * numel(q));
                    rt     = q(index);
                    % normalized response time
                    rtn    = (q(index) - min(q) ) / ( max(q) - min(q) );

                    provider.(['task', num2str(j)]).ava       = ava;
                    provider.(['task', num2str(j)]).rt        = rt;
                    provider.(['task', num2str(j)]).rtn       = rtn;
                    provider.(['task', num2str(j)]).onService = 1;
                else
                    provider.(['task', num2str(j)]).onService = 0;
                end                   
            end

            providers = [providers, provider];
        end
    end

    NP = numel(providers);

    services = {};
    index = ones(1, NT);
    for i=1:NP
        provider = providers(i);
        for j=1:NT
            onService = provider.(['task', num2str(j)]).onService;
            if onService == 1
                name = provider.ProviderName;        
                services{j}{index(j)} = struct('ProviderName', name, ...
                    'rtn', provider.(['task', num2str(j)]).rtn, ...
                    'rt', provider.(['task', num2str(j)]).rt, ...
                    'ava', provider.(['task', num2str(j)]).ava);
                index(j) = index(j) + 1;  
            end        
        end
    end

    filename = ['t', num2str(time) ,'-providers-', num2str(NP), '-tasks-', num2str(NT)];
    save(filename, 'services', 'providers');
end

