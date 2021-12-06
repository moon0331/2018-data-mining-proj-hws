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
Xtrain=X(1:400,:);
ytrain=y(1:400,:);
Xtest=X(401:end,:);
ytest=y(401:end,:);
fprintf('done\n');

fprintf('2. Implement the Least Squares Regression, and report the w by rounding the numbers to 4 decimal places.\n');
w=(Xtrain.'*Xtrain)\Xtrain.'*ytrain; %faster way to solve inv(Xtrain.' * X) * X.' * y
disp("w = ");
disp(round(w,4));

fprintf('3. Compute the RMSE on the test dataset. Round the value to 8 decimal places.\n');
ytestPred=Xtest*w;
RMSE=sqrt(mean((ytest-ytestPred).^2));
fprintf("RMSE = %.8f\n", round(RMSE, 8));

fprintf('4. For each feature, represent the ground-truth y values and the predicted y values for the entire dataset.\n');
fprintf('\t\tgraph shown\n');

len=length(X(1,:));
ax=zeros(len); % preallocation
labels=["Relative Compaceness" , "Surface Area"];

figure('position', [300,300,1300,500]);

yPred=X*w;
for k=1:len
    ax(k)=subplot(1,len,k);
    subplot(ax(k));
    plot(X(:,k), y, 'b*', X(:,k), yPred, 'r*');
    xlabel(labels(k));
    ylabel('Heating Load');
    legend("ground-truth", "least squares");
end