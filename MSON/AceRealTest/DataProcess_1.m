clear all;
clc;

fid = fopen('log_2017-11-04.txt');

Data = [];

tline = fgetl(fid);
while ischar(tline)
    if tline(1) == '2'
        time = tline(12:19);
        providers = [];
        
        tline = fgetl(fid);
        
        while tline(1) == 'M'
            % Mac: 69:00:09:BF:A5:A1 -35
            
            mac  = tline(6:22);
            rssi = str2num(tline(24:end));
            
            providers = [providers, struct('mac', mac, 'rssi', rssi)];
            tline = fgetl(fid);
        end
        
        Data = [Data, struct('time', time, 'providers', providers)];
    end
end
fclose(fid);

save('Data_1', 'Data');
