function vec=getNonzeroObj(vect)
    sz=size(vect);
    for i=1:1:sz(1)
        if isequal(vect(i,:),[0 0])==true
            vec=vect(1:i-1,:); %cut zero part
            break
        end 
    end
end