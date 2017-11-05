function DataProcess_5()
    load('Data_4');

    for i=1:numel(Data)
        
        if i == 3
            i = i+0;
        end
        prolongs = [];
        for j=1:numel(Data(i).providers)
            mac = Data(i).providers(j).mac;
            prolong = getProlong(mac, i-1, 1, Data);
            Data(i).providers(j).prolong = prolong;
            prolongs = [prolongs, prolong];
        end
        Data(i).prolongs = prolongs;
    end
    
    save('Data_5', 'Data');
end


function prolong = getProlong(mac, level, prolong, Data)
    if level == 0
        prolong = prolong + 0;
        return;
    end
    if ismember(mac, Data(level).sproviders)        
        prolong = prolong + 1;
        prolong = getProlong(mac, level-1, prolong, Data);
    end
end

