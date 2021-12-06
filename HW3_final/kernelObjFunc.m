function kernelObj=kernelObjFunc(k, labelVec, kernel, count, N)
    kernelObj=0;
    for i=1:1:N
        lab=labelVec(i);
        kernelObj=kernelObj+getKernelDistance(i, lab, kernel, N, labelVec, count(lab)); %sum of kernel distance
        %datanum, clusternum, kernel, N, labelVec, count
    end
end