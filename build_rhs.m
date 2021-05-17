function rhsvec = build_rhs(xs,ys,alpha)
%compute the left hand side vector
np = length(xs) - 1; 
rhsvec=zeros(np,1);

for i=1:1:np-1
    rhsvec(i,1)=(ys(i)*cos(alpha)-xs(i)*sin(alpha))-(ys(i+1)*cos(alpha)-xs(i+1)*sin(alpha));
end
%define entry 1 and np+1
rhsvec(1,1)=0;
rhsvec(np+1,1)=0;
end

