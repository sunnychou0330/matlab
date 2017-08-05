clear;
clc;

data = load('RealDataSet.mat');
data = data.DataSet;

NP = 100;      % Number of mobile service provider
NT = 100;      % Number of tasks in a composition request
TP = 0;       % Probability of service

for i=1:NT
    id = round(rand * numel(data));
    CandidateService(i,:) = data{id};
end

providers = [];
for i=1:NP
    provider = struct('ProviderName', ['p', num2str(i)]);
    ava = 0.5*rand + 0.5;
    for j=1:NT
        if rand > TP
            q = CandidateService(j).QoS;
            index  = ceil(rand(1) * numel(q));
            rt = q(index);
            rt_p = ( max(q) - q(index) ) / ( max(q) - min(q) );
            
            % turn positive attribute to negative attribute
            provider.(['task', num2str(j)]).ava = 1 - ava;
            provider.(['task', num2str(j)]).rt  = rt;
            % qos is an useless attribure, just classify whether provider i
            % has service j
            provider.(['task', num2str(j)]).qos = 1;
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

filename = ['real-providers-', num2str(NP), '-tasks-', num2str(NT)];
save(filename, 'services', 'providers');

