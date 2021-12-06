function [K_dist] = kernel_Distance(idx, cluster, Kernel, N, label, cnt)
    sum = 0;
    sum = sum + Kernel(idx, idx);               %   K(i, i)
    temp = 0; 
        
    for j = 1:N
        if(label(j, 1) == cluster)    % this cluster에 속한다면
            temp = temp + Kernel(idx, j);
        end
    end
    temp = temp/cnt;
    sum = sum - 2 * temp;

    temp = 0;
    for a = 1:N
        for b=1:N
            if(label(a, 1) == cluster && label(b, 1) == cluster)
                temp = temp + Kernel(a, b);
            end
        end
    end
    temp = temp/(cnt*cnt);
    sum = sum + temp;

    K_dist = sum;
end