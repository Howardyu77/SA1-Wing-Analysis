function psixy = psipv(xc,yc,Gamma,x,y)
% get the streamfunction at point (x,y)
%calculate the distance r between (x,y) and (xc,yc)
r=sqrt((x-xc)^2+(y-yc)^2);
%calculate psi at (x,y)
psixy=-(Gamma/(4*pi))*log(r^2);
end