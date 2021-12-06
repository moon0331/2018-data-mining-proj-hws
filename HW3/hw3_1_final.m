load x.mat

%X=X(1:1000,:);
k=5;
obj=Inf(1);
x_size=size(X);
dim=[k x_size(2)];

data=[Inf(x_size(1), x_size(2)) X]; % ���� ����� Ŭ������ / �� �Ÿ� / x��ǥ / y��ǥ

str='input k*2 centroids : \n';
centroid=input(str);
disp(centroid);
disp(size(centroid));
if isequal(size(centroid),dim)==false
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

%test��

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
    fprintf('(i,j)=(%d %d), (%f %f) to (%f %f), norm=%d, beforenorm=%d\n', i, j, X(i,1), X(i,2), centroid(j,1), centroid(j,2),norm, data(i,2));
    data(i,1:2)=[j norm];
    afterCluster=j;
end

disp(data);

while changed~=0
    fprintf('==========��������� Ŭ�����Ϳ� �ִ� ��ǥ(Ŭ�����͹�ȣ, �Ÿ�, ��ǥ)==========\n');
    changed=0;
    
    for j=1:1:k         % Ŭ������ �߽� ������
        in_cluster=data;
        in_cluster(in_cluster(:, 1)~= j, :)= []; %j�� ���ϴ� Ŭ�����͸� ����
        fprintf('before centroid %d = [%f %f]\n', j, centroid(j,1),centroid(j,2));
        disp(in_cluster);
        centroid(j,:)=mean(in_cluster(:,3:4));
        fprintf('after centroid %d = [%f %f]\n\n', j, centroid(j,1),centroid(j,2));
    end
    
    
    fprintf('============================Ŭ�����Ϳ� ���ϴ� ���� ���� ����============================\n');
    for i=1:1:x_size(1) %��� ��ǥ�� ����
        beforeCluster=data(i,1);
        afterCluster=0;
        fprintf('%d (%f %f) (distance=%f) : before cluster number is %d\n', i, data(i, 3), data(i,4), data(i,2), beforeCluster);
        for j=1:1:k %��� Ŭ�����Ϳ� ����
            distVec=X(i,:)-centroid(j,:);
            norm=vecnorm(distVec);
            %fprintf('(i,j)=(%d %d), norm=%d, beforenorm=%d\n', i, j, norm, data(i,2));
            fprintf('distance to %d cluster: (%f %f)~(%f %f) distance is %f\n', j, data(i,3), data(i,4), centroid(j,1), centroid(j,2), norm);
            if norm<data(i,2)
                data(i,1:2)=[j norm];
                afterCluster=j;
            end
        end
        if afterCluster~=0 && beforeCluster~=afterCluster
            fprintf('before cluster %d -> after cluster %d (norm %f)\n',beforeCluster, afterCluster, data(i,2));
            changed=changed+1;
            data(i,1)=afterCluster;
            %fprintf('%d cluster moved!\n',i);
        end
    end

    fprintf('%d changed\n',changed);
    obj=sum(data(:,2));                                   % objective �� Ŭ������ ������
    fprintf('objective function value = %d\n', obj);
end

for i=1:1:x_size(1)
    for j=1:1:k            
        distVecTemp=X(i,:)-centroid(j,:);
        normmmm=vecnorm(distVecTemp);
        fprintf('%d���� Ŭ������#%d������ �Ÿ� : (%f %f)~(%f %f)=>%f\n',i,j,data(i,3),data(i,4),centroid(j,1),centroid(j,2),normmmm);
    end
    fprintf('���� ���ϴ� Ŭ�����ʹ� %d (�Ÿ� %f)\n',data(i,1), data(i,2));
end


hold on
colormap='grymc';
for j=1:1:k
    in_cluster=data;
    in_cluster(in_cluster(:, 1)~= j, :)= []; %j�� ���ϴ� Ŭ�����͸� ����
    scatter(in_cluster(:,3), in_cluster(:,4), [], colormap(j));
    scatter(centroid(j,1), centroid(j,2), 'filled', 'k');
end
hold off