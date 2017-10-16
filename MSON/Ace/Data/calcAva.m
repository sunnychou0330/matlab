function ava = calcAva(mit, time, timeUp, index)
    distance = 1;
    
    future = 0;
    for i=time:timeUp
        if mit(i, index) == 1
            future = future + 1;
        else
            break;
        end
    end
    if future == 1
        distance = 1;
    else
        distance = distance - future * 0.2;
    end    
    if distance < 0
        distance = 0;
    end
    ava = avability(distance);
end

