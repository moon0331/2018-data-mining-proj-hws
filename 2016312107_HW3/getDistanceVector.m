function vec=getDistanceVector(point, centroid)  %�� �������� �ٸ� centroid������ �Ÿ�
    sz=size(centroid);
    vec=zeros(sz(1));
    for i=1:1:sz(1)
        vec(i)=getDistance(point, centroid(i,:)); %for all vector, get distance
    end
end
