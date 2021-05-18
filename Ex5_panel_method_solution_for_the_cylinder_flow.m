clear;
close all;
%define the cylinerical panels
nq=100;
theta = (0:nq)*2*pi/nq;
xs = cos(theta);
ys = sin(theta);
gammas = -2*sin(theta);

%flow condition
alpha=0;

A = build_lhs(xs,ys);
b = build_rhs(xs,ys,alpha); 
gam = A\b;

