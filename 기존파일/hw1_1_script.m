% original data: https://archive.ics.uci.edu/ml/datasets/Energy+efficiency
clear
format longG
load hw1_data.txt
X=hw1_data(:,1:8);
Y=hw1_data(:,9:10);
y=Y(1:500,1);
X=X(1:500,1:2);
save('hw1_data1.mat','X','y');

clear
load hw1_data1.mat
fprintf('1. Set the first 400 rows of the X matrix as the training data whereas the rest is reserved for the test data.\n');

%{
whole_data=[X y];
whole_data=whole_data(randperm(size(whole_data,1)),:); % random shuffle
X=whole_data(:,1:2);
y=whole_data(:,3);
%}

Xtrain=X(1:400,:);
ytrain=y(1:400,:);
xtest=X(401:end,:);
ytest=y(401:end,:);
fprintf('done');

%{
W_pred_slow=inv(X'*X)*X'*y;
disp(round(W_pred_slow, 4)); %4 decimal places 
%}

fprintf('2. Implement the Least Squares Regression, and report the w by rounding the numbers to 4 decimal places.\n')
W_pred=(Xtrain.' * Xtrain) \ Xtrain.' * y; % faster way to solve inv(X.'*X)*X.' * y
disp("W = ");
disp(round(W_pred, 4)); % Q2

fprintf('3. Compute the RMSE on the test dataset. Round the value to 8 decimal places.\n');
ytestPred=Xtest*W_pred;
RMSE=sqrt(mean((ytest - ytestPred).^2));
fprintf("RMSE = %.8f\n", round(RMSE, 8)); % Q3 

fprintf('4. For each feature, represent the ground-truth y values and the predicted y values for the entire dataset.\n');
fprintf('\t\tgraph shown\n');

len=length(X(1,:));
figure;
ax=zeros(len); % preallocation
yPred=X*W_pred;
for k=1:len
    ax(k)=subplot(1,len,k);
    plot(X(:,1),
end
%{
figure('position', [300,300,1300,500]);
len=length(X(1,:));
labels=["Relative Compaceness" , "Surface Area"];

ax=zeros(len); %preallocation

for k=1:len
    ax(k)=subplot(1,len,k);
    subplot(ax(k));
    scatter(X(:,k), y);
    xlabel(labels(k));
    ylabel("Heating Load");

    hold on;

    y_pred_all=X*W_pred;
    scatter(X(:,k), y_pred_all);
    disp(X(:,k));

    legend("ground-truth", "least squares");
    title(strcat('Heating Load---',labels(k)));

    hold off;
end
%}