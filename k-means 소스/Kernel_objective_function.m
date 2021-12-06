function [K_obj] = Kernel_objective_function(k, N, Kernel, cnt, label)
    K_obj = 0;
    
    
    for a=1:N
        i = label(a, 1);
        k_dist = Kernel_Distance(a, i, Kernel, N, label, cnt(1, i)); 
        K_obj = K_obj + k_dist;
    end
end