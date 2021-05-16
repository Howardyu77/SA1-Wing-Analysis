function [infa,infb] = panelinf(xa,ya,xb,yb,x,y)
%   Summary of this function goes here
%   Detailed explanation goes here
a = [xa ya 0];
b = [xb yb 0];
c = [x y 0];

r = c-a;
t = (b-a)/norm(b-a);
m = cross(r,t);
n = cross(t,m)/norm(cross(t,m));

del = sqrt((xb-xa)^2+(yb-ya)^2);
X = dot(r,t);
Y = dot(r,n);


[infa, infb] = refpaninf(del,X,Y);
end


