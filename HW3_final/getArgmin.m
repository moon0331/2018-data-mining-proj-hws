function argmin=getArgmin(vec) %argmin
    argmin=0;
    minval=Inf(1);
    len=length(vec);
    for i=1:1:len
        if minval>vec(i)
            argmin=i; %index of minimum
            minval=vec(i);
        end
    end
end