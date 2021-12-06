function obj=calObjective(clusteredData)
    obj=sum(clusteredData(:,2)); % sum of distance
end