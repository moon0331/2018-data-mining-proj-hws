load x.mat

%X=X(1:20,:);
x_size=size(X);

k=5;
obj=0; %objective
dim=[k, x_size(2)];

data=[Inf(x_size), X]; %���ϴ� Ŭ������, Ŭ������ �߽ɰ��� �Ÿ�, �� ���� x��ǥ, y��ǥ
%center=-6+rand(k,2)*12;

center=zeros(k,x_size(2));
%center=input('input center : (matrix form)\n');
%if isequal(size(center), dim)==false
    center=[-4 6; 5 6; 0 0; 0 -4; 8 -4];
%end


for i=1:1:x_size(1)
    %n=randi(k);
    n=mod(i,k)+1;
    fprintf('%d��° ���� %d��° Ŭ������(%f %f)��\n',i,n, center(n,1), center(n,2));
    data(i,1:2)=[n dist(data(i,3:4), center(n,:))]; 
    fprintf('  Ŭ������\t\t�Ÿ�\t\tx��ǥ\t\ty��ǥ\n');
    disp(data(i,:));
end


changed=-1;
while changed~=0
    fprintf('===========================================================\n');
    changed=0;
    for i=1:1:x_size(1)
        beforeCluster=data(i,1);
        v=calDistFromCluster(X(i,:),center);
        minInfo=argmin_minVal(v);
        if beforeCluster~=minInfo(1)
            fprintf('before %d, after %d\n', beforeCluster, minInfo(1));
            changed=changed+1;
        end
        data(i,1:2)=minInfo;
    end
    for i=1:1:k
        center(i,:)=calMean(data, i); %������
        %fprintf('center %d = (%f %f)\n\n',i, center(i,1), center(i,2));
    end
    
    %disp(data);
    disp(center);
    fprintf('obj value = %f\n',calObjective(data, center));
    fprintf('changed=%d\n',changed);
end

colormap='rygmb';
scatter(center(:,1), center(:,2), 'filled', 'k');
hold on
for i=1:1:k
    inC=in_cluster(data,i);
    scatter(inC(:,3), inC(:,4), [], colormap(i));
end
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function val=dist(x,y)
    val=vecnorm(x-y);
end

function inCluster=in_cluster(data, i)
    temp=data;
    temp(temp(:,1)~=i,:)=[];
    inCluster=temp; %data���� i�� ���ϴ� ��� ������
end

function cntr=calMean(data, i)
    realData=in_cluster(data, i);
    %disp(realData);
    realXY=realData(:,3:4);
    cntr=mean(realXY);
end

function distVector=calDistFromCluster(point, clusterVector) %clusterVector (k,2)
    vSize=size(clusterVector);
    distVector=zeros(vSize(1), 1);
    for i=1:1:vSize(1)
        fprintf('(%f %f) ~ (%f %f)\n',point(1) , point(2), clusterVector(i,1), clusterVector(i,2));
        distVector(i)=dist(point, clusterVector(i));
    end
end

function minVec=argmin_minVal(v)
    argmin=0;
    min=Inf(1);
    for i=1:1:length(v)
        if min>v(i)
            min=v(i);
            argmin=i;
        end
    end
    minVec=[argmin;min];
end

function objValue=calObjective(data, clusterVector)
    vSize=size(clusterVector);
    objValue=0;
    for i=1:1:vSize
        inC=in_cluster(data,i);
        objValue=objValue+sum(inC(:,2));
    end
end