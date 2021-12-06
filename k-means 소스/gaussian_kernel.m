function [kernel] = gaussian_kernel(X)
    
    sigma = get_Sigma(X);
    c = sigma.^2;
    c = c.*2;
    c = 1./c;
    disp(c)
    
    kernel = zeros(N, N);
    for i = 1:N
        for j = 1:N
            kernel(i, j) = exp( - ( c(1, 1) * (X(i,1)-X(j,1))^2 + c(1, 2) * ( X(i, 2) - X(j,2) )^2) );
        end
    end
end