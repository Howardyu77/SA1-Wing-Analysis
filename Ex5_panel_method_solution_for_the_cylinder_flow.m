clear;
close all;
%define the cylinerical panels
np=100;
theta = (0:np)*2*pi/np;
xs = cos(theta);
ys = sin(theta);
gammas = -2*sin(theta);

%flow condition
alpha=pi/15;

A = build_lhs(xs,ys);
b = build_rhs(xs,ys,alpha); 
gam = A\b;

