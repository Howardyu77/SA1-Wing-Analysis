function lhsmat = build_lhs(xs,ys)
%This function assemble the matrix A
np = length(xs) - 1; 
psip = zeros(np,np+1);

for j=1:1:np+1
    for i=1:1:np
        for k=1:1:np
            %get infa and infb at pannel j
                [infa(i,i),infb(i,i)] = panelinf(xs(j),ys(j),xs(j+1),ys(j+1),xm(i,j),ym(i,j));
            if j==1
                psip(i,j)=infa(i,i);
            elseif j==np+1
                [infa(i,i),infb(i,i)] = panelinf(xs(j-1),ys(j-1),xs(j),ys(j),xm(i,j),ym(i,j));
                psip(i,j)=infb(i,i);
            else
                [infa(i,i),infb(i,i)] = panelinf(xs(j),ys(j),xs(j+1),ys(j+1),xm(i,j),ym(i,j));
                psip(i,j)=infa(i,j)+infb(i,j);
            end
        end
    end
end

%initialise lhsmat
lhsmat = zeros(np+1,np+1);

end

