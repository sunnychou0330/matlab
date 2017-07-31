clear;
clc;

data = load('19940410-59591.txt');
map = containers.Map;
[n, d] = size(data);

for i=1:n
    key = num2str(data(i,2));
    if isKey(map, key)
        map(key) = [map(key), data(i,4)];
    else
        map(key) = [];        
    end    
end

keys = map.keys;
[d, n] = size(keys);

DataSet = {};
for i=1:n
    DataSet{i} = struct('ServiceID', keys(i), 'QoS', map(keys{1}));
end

save('RealDataSet', 'DataSet');
