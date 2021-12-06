function [K_label] = make_kernel_label(k, label, Kernel, cnt, N)
    Dist = zeros(N, k);
    K_label = label;
    
    for i=1:N
        for j = 1:k
            Dist(i, j) = Kernel_Distance(i, j, Kernel,N, K_label, cnt(1, j));
        end
    end
    
    for i=1:N
        minIdx = 1;
        for j=2:k
            if( Dist(i, minIdx) > Dist(i, j) )
                minIdx = j;
            end
        end
        K_label(i, 1) = minIdx;
    end
    disp(K_label);
end