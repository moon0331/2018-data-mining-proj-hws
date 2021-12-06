clear
load y.mat

type=input('Enter version \n1. x1 for x axis and x2 for y axis || 2. x1^2-x1 for x axis and x2^2-x2 for y axis : ');
if type==2
    Y(:,1)=Y(:,1).^2 - Y(:,1);
    Y(:,2)=Y(:,2).^2 - Y(:,2);
end

Y=full(Y); %matrix
y_size=size(Y);
N=y_size(1); %number of data

k=2;
dim=[k y_size(2)];

ans_c=input('input c vector ([%f; %f] form) : ');
if isequal(size(ans_c), [2,1])==false
    c=[0.1;0.1];
else
    c=ans_c;
end
fprintf('c value: \n');
disp(c);

ax=zeros(2,1);

%scatter(Y(:,1), Y(:,2));

minX=min(Y(:,1));
maxX=max(Y(:,1));
minY=min(Y(:,2));
maxY=max(Y(:,2));

centroid=zeros(dim);
input_centroid=input('input cluster center(matrix form) : ');
if isequal(size(input_centroid), dim)==false
    for i=1:1:k
        centroid(i,1)=minX+(maxX-minX)*rand(1); % x=x1^2-x1
        centroid(i,2)=minY+(maxY-minY)*rand(1); % y=x2^2-x2
    end
else
    centroid=input_centroid;
end

fprintf('centroid is chosen.(for debugging)\n');
disp(centroid);

label=randi(k, N, 1); % random initial label
kernel=getKernelMatrix(Y, N, c); %here is kernel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
obj=0;
newObj=-1;
while newObj ~= obj
    newObj=obj;
    count=zeros(k,1);
    for i=1:1:N
        for j=1:1:k
            if label(i,1)==j
                count(j,1)=count(j,1)+1;
                break;
            end
        end
    end
    label=makeKernelLabel(k, label, kernel, count, N);
    obj=kernelObjFunc(k, label, kernel, count, N);
    a=1;
end

group=zeros(2,600,2);
for i=1:1:k
    group(i,:,:)=[Y(:,i) label]; %set result
end

hold on
title('Gaussian RBF');
colormap='rb';
for i=1:1:k
    scatter(group(1, label==i), group(2, label==i), colormap(i)); %plot
end

xlabel('x axis');
ylabel('y axis');
hold off