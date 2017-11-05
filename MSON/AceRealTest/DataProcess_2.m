function DataProcess_2()
    load('Data_1.mat');

    for i=1:numel(Data)
        macs = {};
        for j=1:numel(Data(i).providers)
            mac = Data(i).providers(j).mac;
            if isIn(mac, macs) == 1
                Data(i).providers(j).mac = 'delete';
            else
                macs{numel(macs)+1} = mac;
            end
        end
    end
    
    toDelete = [];
    t        = str2num(Data(1).time(7:8)) + 60*str2num(Data(1).time(4:5));
    for i=1:numel(Data)
        currentTime = str2num(Data(i).time(7:8)) + 60*str2num(Data(1).time(4:5));
        if abs(currentTime - t) < 3
            toDelete = [toDelete, i];
        end
        t = currentTime;
        
        indexToDelete = [];
        for j=1:numel(Data(i).providers)
            mac = Data(i).providers(j).mac;
            if strcmp(mac, 'delete')
                indexToDelete = [indexToDelete, j];
            end
        end
        Data(i).providers([indexToDelete]) = [];
    end
    Data([toDelete]) = [];
    
    save('Data_2', 'Data');
end

function res = isIn(mac, macs)
    res = 0;
    for i=1:numel(macs)
        if strcmp(mac, macs{i})
            res = 1;
            return;
        end
    end
end

