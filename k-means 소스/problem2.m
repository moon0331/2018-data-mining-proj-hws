clear
format longG
load ('Y.mat')

Y1 = Y(:, 1);
Y2 = Y(:, 2);

K_means(2, 1, true, [0.1, 0.1],  Y);

