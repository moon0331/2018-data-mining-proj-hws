function vec=getDistanceVector(point, centroid)  %한 지점에서 다른 centroid까지의 거리
    sz=size(centroid);
    vec=zeros(sz(1));
    for i=1:1:sz(1)
        vec(i)=getDistance(point, centroid(i,:)); %for all vector, get distance
    end
end
