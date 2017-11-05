clear all;
clc;

load('Data_2');
map = containers.Map;
index =1;

for i=1:numel(Data);
    for j=1:numel(Data(i).providers)
        key = Data(i).providers(j).mac;
        
        if isKey(map, key)
            Data(i).providers(j).mac = map(key);
        else            
            Data(i).providers(j).mac = index;
            map(key) = index;
            index = index + 1;
        end
    end
end

save('Data_3', 'Data');