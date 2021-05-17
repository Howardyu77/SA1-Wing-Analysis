function lhsmat = build_lhs(xs,ys)
%This function assemble the matrix A
np = length(xs) - 1; 
psip = zeros(np,np+1);


for ip=1:1:np
    for jp=1:1:np+1
        if jp==1
           [infa(ip,jp),infb(ip,jp)] = panelinf(xs(jp),ys(jp),xs(jp+1),ys(jp+1),xs(ip),ys(ip));
           %get infa and infb at point (x(ip),y(ip)) due to the jpth pannel
           psip(ip,jp)=infa(ip,jp);
        elseif jp==np+1
           [infa(ip,jp),infb(ip,jp)] = panelinf(xs(jp-1),ys(jp-1),xs(jp),ys(jp),xs(ip),ys(ip));
           psip(ip,jp)=infb(ip,jp-1);
        else
           [infa(ip,jp),infb(ip,jp)] = panelinf(xs(jp),ys(jp),xs(jp+1),ys(jp+1),xs(ip),ys(ip));
           psip(ip,jp)=infa(ip,jp)+infb(ip,jp-1);
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

