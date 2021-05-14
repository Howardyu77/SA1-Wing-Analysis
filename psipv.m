function psixy = psipv(xc,yc,Gamma,x,y)
%Summary of this function goes here: get the streamfunction at point x,y
%calculate the distance between x,y and xc, yc
r=sqrt((x-xc)^2 + (y-yc)^2);
%calculate psi
psixy=-Gamma/(4*pi)*log(r^2);

end

