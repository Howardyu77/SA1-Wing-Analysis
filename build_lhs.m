
function lhsmat = build_lhs(xs,ys)
%This function assemble the matrix A
np = length(xs) - 1; 
psip = zeros(np,np+1);

for ip=1:np
    for jp=1:np
    end
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


