function ava=avability(distance)
    R = 1; r = 1;
    if distance == 0
        ava = 1;
        return;
    end
    alpha = acos((r * r + distance * distance - R * R)/2.0/r/distance);
    beta  = acos((R * R + distance * distance - r * r)/2.0/R/distance);
    
    ava = beta * R * R + alpha * r * r - (R * R * sin(beta) * cos(beta) + r * r * sin(alpha) * cos(alpha));
    ava = ava / pi;
    % t = t / pi;
end
