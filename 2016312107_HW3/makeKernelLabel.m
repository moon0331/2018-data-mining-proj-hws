function kernelLabel=makeKernelLabel(k, label, kernel, count, N)    
   
    kernelLabel=label; 
    dist=zeros(N,k);
        
    for datanum=1:1:N
        for clusternum=1:1:k
            dist(datanum,clusternum)=getKernelDistance(datanum, clusternum, kernel, N, kernelLabel, count(clusternum));
        end
    end
    
    for i=1:1:N
        argmin=0;
        minval=Inf(1);
        for j=1:1:k
            if minval>dist(i,j)
                argmin=j;
                minval=dist(i,j);
            end
        end
        kernelLabel(i,1)=argmin;
    end
    dist(kernelLabel);
end