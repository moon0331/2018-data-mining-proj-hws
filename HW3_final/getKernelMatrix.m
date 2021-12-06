function kernel=getKernelMatrix(X, N, c)
    % N=600, c=[0.1;0.1]
    kernel=zeros(N,N);
    for i=1:1:N
        for j=1:1:N
            first=(X(i,1)-X(j,1))^2;
            second=(X(i,2)-X(j,2))^2;
            kernel(i,j)=exp( -( c(1) * first + c(2) * second)); %kernel value
        end
    end
end