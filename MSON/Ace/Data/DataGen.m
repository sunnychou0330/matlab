function DataGen(t)     
    data = load('RealDataSet.mat');
    mit  = load('Mit.mat');
    data = data.DataSet;
    mit  = mit.m;

    time   = t;        % Time Point
    timeUp = 8;
    NP     = 94;      % Number of mobile service provider
    NT     = 25;       % Number of Tasks
    TP     = 0;        % Probability of service
    
    % round(rand(1, 25) * 950)
    services = [436   155   152   765   362   913   656   213    63   919   214   130   268   754   562    55   386   783 316   712   599   252   281   513   544];
    
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

