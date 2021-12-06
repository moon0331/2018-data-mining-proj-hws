clear

load x.mat

ax=zeros(2,1);

numPlot=2;
objVec=zeros(200, 2); % array of [nth iteration, its objective value]

obj=0;
k=5;
x_size=size(X);
dim=[k, x_size(2)];

minX=min(X(:,1));
maxX=max(X(:,1));
minY=min(X(:,2));
maxY=max(X(:,2));

centroid=zeros(dim);

input_centroid=input('input cluster center(matrix form) : '); %can put initial point
if isequal(size(input_centroid), dim)==false
    for i=1:1:k %random initialization
        centroid(i,1)=minX+(maxX-minX)*rand(1);
        centroid(i,2)=minY+(maxY-minY)*rand(1); 
    end
else
    centroid=input_centroid;
end

fprintf('center of cluster chosen.(for debugging)\n');
disp(centroid);

clusteredData=putDataIntoCluster(X, centroid); %put data in clutser
beforeLabel=clusteredData(:,1); %label part
afterLabel=zeros(size(beforeLabel)); %initialization

i=0;
while true
    i=i+1;
    centroid=setNewCentroid(centroid, clusteredData, X); %calculate new centroid
    clusteredData=putDataIntoCluster(X, centroid); %put data in clutster
    afterLabel=clusteredData(:,1); %its labeled result
    obj=calObjective(clusteredData); %objective value
    objVec(i,:)=[i obj]; %store objective value
    if isequal(beforeLabel, afterLabel) % if converges, labeled result will be same.
        break
    end
    beforeLabel=afterLabel; %update label to go next iteration
end

objVec=getNonzeroObj(objVec); % only want nonzero part!

fig=figure('Position', [400,400,1500,600]);
ax(1)=subplot(1,numPlot,1);
plot(ax(1), objVec(:,1), objVec(:,2)); % plot objective value
title('objective function');
xlabel('iteration');
ylabel('obj.value');

ax(2)=subplot(1,numPlot,2);
sz=size(centroid);

hold on
colormap='rygbm';
for i=1:1:sz(1)
    in_cluster=inCluster([clusteredData X], i); 
    scatter(in_cluster(:,3), in_cluster(:,4), 'o', colormap(i)); % plot data
end
scatter(centroid(:,1), centroid(:,2), 'filled', 'k'); % plot centroid
title('cluster result');
xlabel('x');
ylabel('y');
hold off