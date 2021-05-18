function [infa, infb] = panelinf(xa,ya,xb,yb,x,y)
%   Calculate influence coefficients fa, fb at (x,y) due to our general panel.
a = [xa ya 0];
b = [xb yb 0];
c = [x y 0];

r = c-a;
t = (b-a)/norm(b-a);
m = [0 0 -1];
n = cross(t,m)/norm(cross(t,m));

del = sqrt((xb-xa)^2+(yb-ya)^2);
X = dot(r,t);
Y = dot(r,n);


[infa, infb] = refpaninf(del,X,Y);
end


