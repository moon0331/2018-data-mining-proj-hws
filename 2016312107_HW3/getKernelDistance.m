function dist=getKernelDistance(datanum, clusternum, kernel, N, labelVec, count)
    dist=kernel(datanum, datanum); %%%%%%%%%%%%%%
    temp=0;
    for j=1:1:N
        if labelVec(j)==clusternum
            temp=temp+kernel(datanum, j);
        end
    end
    dist=dist-2*temp/count; %%%%%%%%%%%%%%%%%%%%
    
    temp=0;
    for i=1:1:N
        for j=1:1:N
            if labelVec(i)==clusternum && labelVec(j)==clusternum
                temp=temp+kernel(i,j);
            end
        end 
    end
    dist=dist+temp/(count*count); %%%%%%%%%%%%%%%%%%
end