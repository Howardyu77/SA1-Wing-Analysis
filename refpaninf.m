function [infa, infb] = refpaninf(del,X,Y)
%X and Y are vectors
%Get infa and infb
Y(find(Y<1.0e-6))= 1.0e-6;
np = length(X)-1;
infa= zeros(np);
infb= zeros(np);

for i=1:np
    I0 = -( X*log(X^2+Y^2) - (X-del)*log((X-del)^2+Y^2)...
     - 2*del+2*Y*(atan(X/Y)-atan((X-del)/Y)) ) / (4*pi);

    I1 = ( (X^2+Y^2)*log(X^2+Y^2) - ((X-del)^2+Y^2)...
     *log((X-del)^2+Y^2) - 2*X*del + del^2 ) / (8*pi);


    infa(i) = I0*(1-X/del) - I1/del;
    infb(i) = I0*X/del + I1/del;
end
end

