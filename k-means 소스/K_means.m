function [label] = K_means(k, center, Is_Kernel, c, X)
       
       new_obj = -1;
       obj = 0;
       iteration = 1;
       
        
    if(Is_Kernel == false)
       X1 = X(:,1);
       X2 = X(:,1);
       
       minX1 = min(X1);
       minX2 = min(X2);
       maxX1 = max(X1);
       maxX2 = max(X2);
       
       center1 = minX1 + (maxX1 - minX1) * rand(k, 1);
       center2 = minX2 + (maxX2 - minX2) * rand(k, 1);
        
       center = [center1, center2];
        
       iter_list=[];
       obj_list=[];
       
       while (new_obj ~= obj)
           new_obj = obj;
           label = make_label(k, center, X);

           cnt = zeros(k, 1);
           new_center = zeros(k, 2);
           for i = 1:size(X, 1)
               temp = label(i, 1); 

               new_center(temp, 1) = new_center(temp, 1) + X(i, 1);
               new_center(temp, 2) = new_center(temp, 2) + X(i, 2);

               cnt(temp, 1) = cnt(temp, 1) + 1;
           end
           for i = 1:k
                center(i, 1) = new_center(i, 1)/cnt(i, 1); 
                center(i, 2) = new_center(i, 2)/cnt(i, 1);
           end
           obj = objective_function(k, center, X, cnt, label);
           
           iter_list = [iter_list, iteration];
           obj_list = [obj_list, obj];
           iteration = iteration + 1;
       end
       disp(obj)
       labeled_X1 = [X(:, 1), label];
       labeled_X2 = [X(:, 2), label];
       
       plot(labeled_X1(label == 1), labeled_X2(label == 1), '*' )
       hold on
       plot(labeled_X1(label == 2), labeled_X2(label == 2), '*' )
       plot(labeled_X1(label == 3), labeled_X2(label == 3), '*' )
       plot(labeled_X1(label == 4), labeled_X2(label == 4), '*' )
       plot(labeled_X1(label == 5), labeled_X2(label == 5), '*' )
       
       plot(center(:, 1), center(:, 2), 'k+');
       
       legend('c1', 'c2', 'c3', 'c4', 'c5', 'center');  
       
       hold off
       
       figure;
       plot(iter_list', obj_list', '*')
       
       legend('Objective Function');
       xlabel('Iteration');
       ylabel('Objective Function');
       
       hold off
       
    else
        N = size(X, 1);
        new_obj = -1;
        obj = 0;
        label = zeros(N, 1);
        for i=1:N
            label(i, 1) = randi(2);
        end
       
        kernel = zeros(N, N);
        for i = 1:N
            for j = 1:N
                kernel(i, j) = exp( - ( c(1, 1) * (X(i,1)-X(j,1))^2 + c(1, 2) * ( X(i, 2) - X(j,2) )^2) );
            end
        end
        while(new_obj ~= obj)
        %for a = 1:2
            new_obj = obj;
            cnt = zeros(1, k);
            
            for i=1:N
                for j =1:k
                    if(label(i, 1) == j)
                        cnt(1, j) = cnt(1, j) + 1;
                        break;
                    end
                end
            end
            disp(cnt);
            
            label = make_kernel_label(k, label, kernel,cnt, N);
           
            obj = Kernel_objective_function(k, N, kernel, cnt, label);
            
        end
       %disp(obj)
       labeled_X1 = [X(:, 1), label];
       labeled_X2 = [X(:, 2), label];
       
       plot(labeled_X1(label == 1), labeled_X2(label == 1), 'r*' )
       hold on
       plot(labeled_X1(label == 2), labeled_X2(label == 2), 'b*' )
       legend('c1', 'c2');  
    end
end