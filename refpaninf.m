function [infa, infb] = refpaninf(del,X,Yin)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if abs(Yin) < 1.0e-6
    Y = 1.0e-6;
else
    Y = Yin;
end 

I_0 = -(1/(4)*pi)*(X*log(X^2+Y^2)-(X-del)*log((X-del)^2+Y^2)-2*del+2*Y*(atan(X/Y)-atan((X-del)/Y)));
I_1 = (1/(8*pi))*((X^2+Y^2)*log(X^2+Y^2)-((X-del)^2+Y^2)*log((X-del)^2+Y^2)*log((X-del)^2+Y^2)-2*X*del+del^2);
infa = (1-X/del)*I_0-I_1/del;
infb = (X/del)*I_0+I_1/del;
end

