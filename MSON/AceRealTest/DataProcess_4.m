clear all;
clc;

load('Data_3');

for i=1:numel(Data)
    providers = [];
    for j=1:numel(Data(i).providers)
        providers = [providers, Data(i).providers(j).mac];
    end
    Data(i).sproviders = providers;
end

save('Data_4', 'Data');