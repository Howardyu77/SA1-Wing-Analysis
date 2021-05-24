function [infa, infb] = panelinf(xa,ya,xb,yb,x,y)
%   Calculate influence coefficients fa, fb at (x,y) due to our general panel.
a = [xa ya];
b = [xb yb];
c = [x y];

r = c-a;
del = norm(b-a);
t = (b-a)/del;
n = [-t(2),t(1)];

X = dot(r,t);
Y = dot(r,n);

[infa, infb] = refpaninf(del,X,Y);
end


