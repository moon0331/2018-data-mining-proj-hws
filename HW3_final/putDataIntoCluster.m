function clusteredData=putDataIntoCluster(X, centroid)
    sz=size(X);
    clusteredData=zeros(sz(1), 2);
    for i=1:1:sz(1)
        distVec=getDistanceVector(X(i,:), centroid);
        argmin=getArgmin(distVec);
        clusteredData(i,:)=[argmin distVec(argmin)]; % argmin and its distance
    end
end