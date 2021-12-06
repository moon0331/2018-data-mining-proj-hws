load x.mat % let this matrix X

% label과 distVector 합할수 있음?

k=5;
x_dim=size(X);
dim=[k x_dim(2)];
obj=Inf(1); %objective function


center=rand(dim)*12; % initial center (수정 필요할수도)
label=repmat([0, Inf(1)], x_dim(1), 1); % nearest cluster and distance
distVector=zeros(x_dim(1),2);
for i=1:1:k
    fprintf('%dth center',i);
    disp(center(i,:));
end

row=x_dim(1); % 1000

changed=-1;
while changed~=0
    fprintf('=======================\n');
    changed=0;
    for i=1:1:x_dim(1) % for all given data
        for j=1:1:k % for all cluster
            %fprintf('%d %d\nX=[%f %f], center=[%f %f]\n', ...
                %i,j, X(i,1), X(i,2), center(j,1),center(j,2));
            distVec=X(i,:)-center(j,:); %distance vector
            disp(distVec);
            distance=vecnorm(distVec); %distance를 위치벡터로 바꾸어야!!!!!!!!!!!!!!
            %fprintf('distance vector=[%f %f] and distance=%f\n\n', ...
                %distVec(1), distVec(2), distance);
            if label(i,2)>distance
                changed=changed+1;
                label(i,:)=[j distance];
                distVector(i,:)=distVec;
            end
        end
        %disp(label(i,:));
    end
    for j=1:1:k
        in_cluster= label;
        in_cluster(in_cluster(:, 1)~= j, :)= [];
        sz=length(in_cluster);
        m=mean(in_cluster);
        %disp(m);
        if isnan(m(2))
            m(1)=j;
        end
        fprintf('%d번째 클러스터 간의 평균 거리 : %f (%d개)\n',m, sz);
    end
    fprintf('changed value : %d\n',changed);
end

%disp(label);

%{
for element=list
    %doSomething
end
%}

% scatter(Y(:,1),Y(:,2))