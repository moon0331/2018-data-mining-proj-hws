clear
format longG
load ('X.mat')

X1 = X(:, 1);
X2 = X(:, 2);

center = [];

label = K_means(5, center, false, 0,  X);