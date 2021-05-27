function lhsmat = build_lhs(xs,ys)
%This function assemble the matrix A
np = length(xs) - 1; 
psip = zeros(np,np+1);

infa = zeros(np,np);
infb = zeros(np,np);
for ip=1:np
    for jp=1:np
        [infa(ip,jp),infb(ip,jp)] = panelinf(xs(jp),ys(jp),xs(jp+1),ys(jp+1),xs(ip),ys(ip));
    end
end
        
%build psi
for ip=1:np
    psip(ip,1) = infa(ip,1);
    for jp=2:np
        psip(ip,jp) = infa(ip,jp)+infb(ip,jp-1);
    end
    psip(ip,np+1) = infb(ip,np);
end

%build lhsmat
lhsmat = zeros(np+1,np+1);
for jp=1:1:np+1
    for ip=2:1:np
        %place the differences between rows into 2nd to np th rows of A
        lhsmat(ip,jp)= psip(ip,jp)- psip(ip-1,jp);
    end
end
%setting the entries of the left hand side matrix that correpond to zero
%gammas

lhsmat(1,1)= 1;
lhsmat(1,2)= -1;
lhsmat(1,np)= 1;
lhsmat(1,3)= 0.5;
lhsmat(1,np-1)= -0.5;

lhsmat(np+1,np+1)=-1;
lhsmat(np+1,2)=-1;
lhsmat(np+1,np)=1;
lhsmat(np+1,3)=0.5;
lhsmat(np+1,np-1)=-0.5;


%{
Alternate:
Instead of storing entire matrix of infa and infb, just store current and
previous values. This means we do mot have to look up large matrices.
Work on this after vectorising the code.
%}