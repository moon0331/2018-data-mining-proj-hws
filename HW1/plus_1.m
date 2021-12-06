% original data: https://archive.ics.uci.edu/ml/datasets/Energy+efficiency
clear
format longG
load hw1_data.txt
X=hw1_data(:,1:8);
Y=hw1_data(:,9:10);
y=Y(1:500,1);
X=X(1:500,1:4);
save('hw1_data2.mat','X','y');


X_train_s=X([1:400],[1:4]); 
X_train=[ones(400,1) X_train_s(:,1) X_train_s(:,2) X_train_s(:,3) X_train_s(:,4)];
Y_train=y([1:400]);
w= inv(X_train'*X_train)*X_train'*Y_train;   


X_test_s=X([401:500],[1:4]);
X_test=[ones(100,1) X_test_s(:,1) X_test_s(:,2) X_test_s(:,3) X_test_s(:,4)]; 
Y_test=X_test*w;  
Y_real=y([401:500]); 
RMSE=sqrt(sum((Y_real(:)-Y_test(:)) .^2)/100) ; 

I=eye(5); 
rw=inv(X_train'*X_train+0.01*I)*X_train'*Y_train; 
Y_ridge=X_test*rw; 
RMSE_ridge=sqrt(sum((Y_real(:)-Y_ridge(:)) .^2)/100) ; 


X_whole=[ones(500,1) X(:,1) X(:,2) X(:,3) X(:,4)]; 
Y_whole=X_whole*w; 
Y_ridge=X_whole*rw;

scatter(X(:,1) ,y,'*');
hold on
scatter(X(:,1) ,Y_whole,400,'.');  
scatter(X(:,1) ,Y_ridge,40,'o');   
legend('ground-truth', 'least squares', 'ridge');
xlabel('Relative Compactness');
ylabel('Heating Load'); 
title('Subplot 1')
hold off

figure
scatter(X(:,2) ,y,'*');
hold on
scatter(X(:,2) ,Y_whole,400,'.');  
scatter(X(:,2) ,Y_ridge,40,'o');   
legend('ground-truth', 'least squares', 'ridge');
xlabel('Surface Area');
ylabel('Heating Load');
title('Subplot 2')
hold off

figure
scatter(X(:,3) ,y,'*');
hold on
scatter(X(:,3) ,Y_whole,400,'.');  
scatter(X(:,3) ,Y_ridge,40,'o');   
legend('ground-truth', 'least squares', 'ridge');
xlabel('Wall Area');
ylabel('Heating Load');
title('Subplot 3')
hold off

figure
scatter(X(:,4) ,y,'*');
hold on
scatter(X(:,4) ,Y_whole,400,'.');  
scatter(X(:,4) ,Y_ridge,40,'o');   
legend('ground-truth', 'least squares', 'ridge');
xlabel('Roof Area');
ylabel('Heating Load');
title('Subplot 4')
hold off

save('hw1_data2.mat','X','y','X_train','w','Y_train','RMSE','I','RMSE_ridge');




clear
load hw1_data2.mat