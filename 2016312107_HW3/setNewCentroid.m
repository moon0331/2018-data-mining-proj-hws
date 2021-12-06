function newCentroid=setNewCentroid(centroid, clusteredData, X) 
    newCentroid=centroid;
    sz=size(centroid);
    fullData=[clusteredData X];
    for i=1:1:sz(1)
        in_cluster=inCluster(fullData, i); 
        %disp(in_cluster);
        newCentroid(i,:)=mean(in_cluster(:,3:4)); %mean point of data in the cluster
    end
end