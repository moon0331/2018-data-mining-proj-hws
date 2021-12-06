function [sigma] = get_Sigma(X)
    mean = [0, 0];
    sigma = [0, 0];
    row = size(X, 1);
    squX = X.^2;
    for i = 1:row
        mean(1, 1) = mean(1, 1) + X(i, 1);
        mean(1, 2) = mean(1, 2) + X(i, 2);
        sigma(1, 1) = sigma(1, 1) + squX(i, 1);
        sigma(1, 2) = sigma(1, 2) + squX(i, 2);
    end
    mean = mean./row;
    sigma = sigma./row;
    
    squMean = mean.^2;
    
    sigma = sigma - squMean;
end