function [obj] = objective_function(k, center, X, cnt, label)
    obj = 0;
    for i = 1:size(X, 1)
        temp = label(i, 1);
        dist = get_Distance(X(i, 1), X(i, 2), center(temp, 1), center(temp, 2) );
        dist = dist^2;
        
        obj = obj + dist;
    end
end