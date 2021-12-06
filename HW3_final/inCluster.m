function inC=inCluster(clusteredData, i)
    inC=clusteredData;
    inC(inC(:,1)~=i,:)=[]; %get data info only if the data is in i-th cluster
end