clear;
clc;


NP = 20;      % Number of mobile service provider
NT = 15;      % Number of tasks in a composition request
TP = 0;       % Probability of service

providers = [];
for i=1:NP
    provider = struct('ProviderName', ['p', num2str(i)]);
    ava = rand(1);
    for j=1:NT
        if rand > TP
            rt = rand(1);
            qos = rt + ava;
            provider.(['task', num2str(j)]).ava = ava;
            provider.(['task', num2str(j)]).rt  = rt;
            provider.(['task', num2str(j)]).qos = qos;
        else
            provider.(['task', num2str(j)]).qos = 0;
        end       
    end
    providers = [providers, provider];
end

services = {};
index = ones(1, NT);
for i=1:NP
    provider = providers(i);
    for j=1:NT
        qos = provider.(['task', num2str(j)]).qos;
        if qos ~= 0
            name = provider.ProviderName;        
            services{j}{index(j)} = struct('ProviderName', name, 'qos', qos, ...
                'rt', provider.(['task', num2str(j)]).rt, ...
                'ava', provider.(['task', num2str(j)]).ava);
            index(j) = index(j) + 1;  
        end        
    end
end

filename = ['rand-providers-', num2str(NP), '-tasks-', num2str(NT)];
save(filename, 'services', 'providers');

