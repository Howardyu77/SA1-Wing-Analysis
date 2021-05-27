
function lhsmat = build_lhs(xs,ys)
%This function assemble the matrix A
np = length(xs) - 1; 
psip = zeros(np,np+1);
infa = zeros(np);
infb = zeros(np);

[infa, infb] = panelinf(xs,ys,xs,ys);

for ip=1:np
    psip(ip,1) = infa(1);
    for jp=2:np
        psip(ip,jp) = infa(jp)+infb(jp-1);
    end
    psip(ip,np+1) = infb(np);
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
lhsmat(1,1)=1;
lhsmat(np+1,np+1)=1;


