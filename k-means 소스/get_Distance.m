function [dist] = get_Distance(a1, a2, b1, b2)
    dist = sqrt((b1-a1)^2 + (b2-a2)^2);
end