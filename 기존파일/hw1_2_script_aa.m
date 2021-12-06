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

whole_data=[X y];
whole_data=whole_data(randperm(size(whole_data,1)),:); % random shuffle
X=whole_data(:,1:4);
y=whole_data(:,5);

train_x=X(1:400,:);
train_y=y(1:400,:);
test_x=X(401:500,:);
test_y=y(401:500,:); % same approach

XtX=X.'*X;
I=eye(length(XtX));
w_pred_ridge=(XtX + 0.01*I)\X.'*y;
w_pred_ls=(XtX)\X.'*y;
disp(round(w_pred_ridge, 4));

figure('position', [100,100,700,700]);
len=length(X(1,:));
labels=["Relative Compaceness" , "Surface Area", "Wall Area", "Roof Area"];

ax=zeros(len);

for k=1:len
    ax(k)=subplot(2, len/2, k);
    subplot(ax(k));
    scatter(X(:,k), y);
    xlabel(labels(k));
    ylabel("Y value");
    
    hold on;
    
    y_pred_all=X*w_pred_ridge;
    scatter(X(:,k), y_pred_all);

    legend("ground-truth", "least squares");
    title(strcat('Heating Load---',labels(k))); 
    
    hold off;
    hold on;
    
    y_pred_as=X*w_pred_ls;
    scatter(X(:,k), y_pred_as);

    legend("ground-truth", "Ridge", "LS");
    title(strcat('Heating Load---',labels(k)));

    hold off;
end
