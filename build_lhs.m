function lhsmat = build_lhs(xs,ys)
%This function assemble the matrix A
np = length(xs) - 1; 
psip = zeros(np,np+1);

[infa(i,i),infb(i,i)] = panelinf(xs(j),ys(j),xs(j+1),ys(j+1),xm(i,j),ym(i,j));

for ip=1:1:np+1
    for jp=1:1:np+1
        if jp==1
           
        elseif jp==np+1
           
           
        else
           
           
        end
    end
end
%initialise lhsmat
lhsmat = zeros(np+1,np+1);

end

