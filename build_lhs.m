function lhsmat = build_lhs(xs,ys)
%This function assemble the matrix A
np = length(xs) - 1; 
psip = zeros(np,np+1);
% generate matrices xm, ym, infa, infb


for ip=1:1:np
    for jp=1:1:np+1
        if jp==1
            [infa(jp,jp),infb(jp,jp)] = panelinf(xs(jp),ys(jp),xs(jp+1),ys(jp+1),xs(jp),ys(jp));
           psip(ip,jp)=infa(jp,jp);
        elseif jp==np+1
           [infa(jp,jp),infb(jp,jp)] = panelinf(xs(jp-1),ys(jp-1),xs(jp),ys(jp),xs(jp),ys(jp));
           psip(ip,jp)=infb(jp,jp);
        else
           [infa(jp,jp),infb(jp,jp)] = panelinf(xs(jp),ys(jp),xs(jp+1),ys(jp+1),xs(jp),ys(jp));
           psip(ip,jp)=infa(jp,jp)+infb(jp-1,jp-1);
        end
    end
end



%initialise lhsmat
lhsmat = zeros(np+1,np+1);

for jp=1:1:np-1
    for ip=1:1:np-1
        lhsmat(ip,jp)= psip(ip+1,jp)- psip(ip,jp);
    end
end

end