function lhsmat = build_lhs(xs,ys)
%This function assemble the matrix A
np = length(xs) - 1; 
psip = zeros(np,np+1);

for ip=1:1:np
    for jp=1:1:np+1
        if jp==1

           %get infa and infb at point (x(ip),y(ip)) due to the first pannel
           psip(ip,jp)=infa;
        elseif jp==np+1
            %compute infa and infb at (x(ip),y(ip)) due to the last pannel
           [~,infb] = panelinf(xs(jp-1),ys(jp-1),xs(1),ys(1),xs(ip),ys(ip));
           psip(ip,jp)=infb;
        else
           [infa,~] = panelinf(xs(jp),ys(jp),xs(jp+1),ys(jp+1),xs(ip),ys(ip));
           psip(ip,jp)=infa;
           [~,infb] = panelinf(xs(jp-1),ys(jp-1),xs(jp),ys(jp),xs(ip),ys(ip));
           psip(ip,jp)=psip(ip,jp)+infb;
        end
    end
end


%initialise lhsmat
lhsmat = zeros(np+1,np+1);

for jp=1:1:np+1
    for ip=2:1:np
        %place the differences between rows into 2nd to np th rows of A
        lhsmat(ip,jp)= psip(ip,jp)- psip(ip-1,jp);
    end
end
%setting the entries of the left hand side matrix that correpond to zero
%gammas
lhsmat(1,1)=1;
lhsmat(np+1,np+1)=1;
