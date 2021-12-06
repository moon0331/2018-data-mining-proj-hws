% original data: https://archive.ics.uci.edu/ml/datasets/Energy+efficiency
clear
format longG
load hw1_data.txt
X=hw1_data(:,1:8);
Y=hw1_data(:,9:10);
y=Y(1:500,1);
X=X(1:500,1:4);
save('hw1_data2.mat','X','y');

clear
load hw1_data2.mat
warning('off','all');

fprintf("5. Set the first 400 rows of the X matrix as the training data \nwhereas the rest is reserved for the test data.\n");

X=[ones(500,1), X];
Xtrain=X(1:400,:);
ytrain=y(1:400,:);
Xtest=X(401:end,:);
ytest=y(401:end,:); % same approach
fprintf("Done.\n");

fprintf("6. Compute the RMSE of the Least Squares and the Ridge Regression (�� = 0.01). \nRound the numbers to 4 decimal places.\n");
wLS = (Xtrain.'*Xtrain)\Xtrain.'*ytrain;
yLS = Xtest * wLS;
RMSE_LS = sqrt(mean((ytest-yLS).^2));
RMSE_LS = round(RMSE_LS, 4);
fprintf("RMSE of the Least Squares on test data = %.4f\n", RMSE_LS);

I=eye(length(Xtrain.' * Xtrain));
wRidge = (Xtrain'*Xtrain+0.01*I)\Xtrain'*ytrain; 
yRidge = Xtest * wRidge;
RMSE_Ridge = sqrt(mean((ytest-yRidge).^2));
RMSE_Ridge = round(RMSE_Ridge, 4);
fprintf("RMSE of the Ridge Regression on test data = %.4f\n", RMSE_Ridge);

yLS_pred = X * wLS;
yRidge_pred = X * wRidge;

figure('position', [0,0,1000,1000]);
labels=[" Relative Compactness", " Surface Area", " Wall Area", " Roof Area"];
legendlocation=["southeast", "southwest", "southeast", "northeast"];
len=length(X(1,:))-1;
ax=zeros(len-1);
for k=1:len
    ax(k)=subplot(2,2,k);
    subplot(ax(k));
    plot(X(:,k+1), y, 'b*', X(:,k+1), yLS_pred, 'r*', X(:,k+1), yRidge_pred, 'k*');
    xlabel(labels(k));
    ylabel('Heating Load');
    title(strcat('Heating Load vs', labels(k)));
    legend("ground-truth", "least squares", "Ridge", "location", legendlocation(k));
end

