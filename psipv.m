function psixy = psipv(xc,yc,Gamma,x,y)
%Summary of this function goes here: get the streamfunction at point (x,y)
%calculate the distance r between (x,y) and (xc,yc)
rsquared=((x-xc)^2+(y-yc)^2);
%calculate psi at (x,y)
psixy=-(Gamma/(4*pi))*log(rsquared);
end

