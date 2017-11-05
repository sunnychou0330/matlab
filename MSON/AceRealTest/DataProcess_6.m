clear all;
clc;

load('Data_5');

for i=1:numel(Data)
    Data(i).score = sum(Data(i).prolongs);
end

save('Data_6', 'Data');