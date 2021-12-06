load x.mat

x_size=size(X);

k=5;
dim=[k x_size(1)];
obj=0;

data=[Inf(x_size) X]; % 가장 가까운 클러스터 | 거기까지의 거리 | x좌표 | y좌표

centroid=[-2 -4; 4 4; 2 2; -2 6; 8 6]; %입력받기

changed=-1;

for i=1:1:x_size(1)
    n=mod(i,5)+1;
    data(i,1)=n;
    data(i,2)=distance(data(i,3:4),centroid(n,:));
end

while changed~=0
    for i=1:1:k
        inC=in_cluster(data, i);
        %disp(inC);
        centroid(i,:)=newCentroid(inC);
        disp(centroid(i,:));
    end
    for i=1:1:x_size(1)
        minInfo=minData(X(i), centroid);
        %disp(minInfo);
    end
    change=0;
end
showGraph(data, centroid);

function val=distance(x,y)
    val=vecnorm(x-y);
end

function inC=in_cluster(data, i)
    inC=data;
    inC(inC(:,1)~=i,:)=[];
end

function cent=newCentroid(inClusterData)
    cent=mean(inClusterData(:,3:4));
end

function minInfo=minData(point, centroidVector)
    argmin=0;
    minValue=Inf(1);
    n=size(centroidVector);
    distVector=zeros(n);
    for i=1:1:n
        distVector(i)=distance(point, centroidVector(i));
    end
    for i=1:1:n
        if minValue>distVector(i)
            argmin=i;
            minValue=distVector(i);
        end
    end
    minInfo=[argmin, minValue];
end

function graph=showGraph(data, centroid)
    scatter(centroid(:,1), centroid(:,2), 'filled', 'k');
    hold on
    sz=size(centroid);
    colormap='rygbm';
    for i=1:1:sz(1)
        inC=in_cluster(data, i);
        scatter(inC(:,3), inC(:,4), [], colormap(i));
    end
    hold off
    graph=0;
end