load x.mat

X=X(101:200,:);
k=5;
obj=Inf(1);
x_size=size(X);
dim=[k x_size(2)];

data=[Inf(x_size(1), x_size(2)) X]; % 가장 가까운 클러스터 / 그 거리 / x좌표 / y좌표

str='input k*2 centroids : \n';
centroid=input(str);
disp(centroid);
disp(size(centroid));
if isequal(size(centroid),dim)==false
    disp('size not OK\n');
    centroid=zeros(dim);
    centroid(1,:)=[-2 -4];
    centroid(2,:)=[4 -4];
    centroid(3,:)=[2 2];
    centroid(4,:)=[-2 6];
    centroid(5,:)=[8 6];
end
fprintf('real centroid:\n');
disp(centroid);

%centroid=rand(dim)*12;

%test용

%{
centroid(1,:)=[-2 -4];
centroid(2,:)=[4 -4];
centroid(3,:)=[2 2];
centroid(4,:)=[-2 6];
centroid(5,:)=[8 6];
%}


changed=-3;


for i=1:1:x_size(1)
    j=randi(k);
    distVec=X(i,:)-centroid(j,:);
    norm=vecnorm(distVec);
    fprintf('(i,j)=(%d %d), norm=%d, beforenorm=%d\n', i, j, norm, data(i,2));
    data(i,1:2)=[j norm];
    afterCluster=j;
end

disp(data);

while changed~=0
    fprintf('==========현재까지의 클러스터에 있는 좌표(클러스터번호, 거리, 좌표)==========\n');
    changed=0;
    
    for j=1:1:k         % 클러스터 중심 재조정
        in_cluster=data;
        in_cluster(in_cluster(:, 1)~= j, :)= []; %j에 속하는 클러스터만 정함
        fprintf('before centroid %d = [%f %f]\n', j, centroid(j,1),centroid(j,2));
        disp(in_cluster);
        centroid(j,:)=mean(in_cluster(:,3:4));
        fprintf('after centroid %d = [%f %f]\n', j, centroid(j,1),centroid(j,2));
    end
    
    
    fprintf('============================클러스터에 속하는 원소 변경 과정============================\n');
    for i=1:1:x_size(1) %모든 좌표에 대해
        beforeCluster=data(i,1);
        afterCluster=0;
        fprintf('%d (%f %f) (distance=%f) : before cluster number is %d\n', i, data(i, 3), data(i,4), data(i,2), beforeCluster);
        for j=1:1:k %모든 클러스터에 대해
            distVec=X(i,:)-centroid(j,:);
            norm=vecnorm(distVec);
            %fprintf('(i,j)=(%d %d), norm=%d, beforenorm=%d\n', i, j, norm, data(i,2));
            if norm<data(i,2)
                data(i,1:2)=[j norm];
                afterCluster=j;
                fprintf('new distance : (%f %f)~(%f %f) distance is %f\n',data(i,3), data(i,4), centroid(j,1), centroid(j,2), norm);
            end
        end
        if afterCluster~=0 && beforeCluster~=afterCluster
            fprintf('before cluster %d -> after cluster %d\n',beforeCluster, afterCluster);
            changed=changed+1;
            data(i,1)=afterCluster;
            %fprintf('%d cluster moved!\n',i);
        end
    end

    fprintf('%d changed\n',changed);
    obj=sum(data(:,2));                                   % objective 및 클러스터 재조정
    fprintf('objective function value = %d\n', obj);
end

for i=1:1:x_size(1)
    for j=1:1:k            
        distVecTemp=X(i,:)-centroid(j,:);
        normmmm=vecnorm(distVecTemp);
        fprintf('%d에서 클러스터#%d까지의 거리 : (%f %f)~(%f %f)=>%f\n',i,j,data(i,3),data(i,4),centroid(j,1),centroid(j,2),normmmm);
    end
    fprintf('따라서 속하는 클러스터는 %d (거리 %f)\n',data(i,1), data(i,2));
end


hold on
colormap='grymc';
for j=1:1:k
    in_cluster=data;
    in_cluster(in_cluster(:, 1)~= j, :)= []; %j에 속하는 클러스터만 정함
    scatter(in_cluster(:,3), in_cluster(:,4), [], colormap(j));
end
scatter(centroid(:,1), centroid(:,2), 'filled', 'k');
hold off