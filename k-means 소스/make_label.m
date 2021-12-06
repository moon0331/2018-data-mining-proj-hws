function [label] = make_label(k, center, X)
    label = zeros( size(X,1), 1);
    for i = 1:size(X, 1)
       list = zeros(k, 1);
        for j = 1:k
            Dist = get_Distance(X(i, 1), X(i, 2), center(j, 1), center(j, 2));
            list(j, 1) = Dist;
        end
        min = 1;
        for a = 2:k
            if ( list(a, 1) < list(min, 1) )
                min = a;
            end
        end
        label(i, 1) = min;
    end
end