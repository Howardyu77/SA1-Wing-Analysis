function lhsmat = build_lhs(xs,ys)
%This function assemble the matrix A
np = length(xs) - 1; 
psip = zeros(np,np+1);



for ip=1:1:np
    for jp=1:1:np+1
        [infa(ip,ip),infb(ip,ip)] = panelinf(xs(jp),ys(jp),xs(jp+1),ys(jp+1),xm(ip,ip),ym(ip,ip));
        if jp==1
           psip(ip,jp)=infa(ip,ip);
        elseif jp==np+1
           psip(ip,jp)=infb(ip-1,ip-1);
        else
           psip(ip,jp)=infa(ip,ip)+infb(ip-1,ip-1);
           
        end
    end
end


%initialise lhsmat
lhsmat = zeros(np+1,np+1);
for jp=1:1
end

