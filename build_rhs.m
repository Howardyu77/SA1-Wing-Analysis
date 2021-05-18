function rhsvec = build_rhs(xs,ys,alpha)
%compute the left hand side vector
np = length(xs) - 1; 
rhsvec=zeros(np+1,1);

for i=2:1:np
    rhsvec(i,1)=(ys(i-1)*cos(alpha)-xs(i-1)*sin(alpha))-(ys(i)*cos(alpha)-xs(i)*sin(alpha));
end
%define entry 1 and np+1
rhsvec(1,1)=0;
rhsvec(np+1,1)=0;
end

