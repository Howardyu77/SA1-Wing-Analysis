function [cl, cd] = forces(circ,cp,delstarl,thetal,delstaru,thetau)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
cl=-2*circ;
%last points in the arrays are te
theta_te=thetal(end)+thetau(end);
delstar_te=delstaru(end)+delstarl(end);
H_te=delstar_te/theta_te;
ue_te= sqrt(1-cp(end));

theta_inf=theta_te*ue_te^((H_te+5)/2);


cd=2*theta_inf; %here chord length c is 1 and combine contributions from both surfaces
end

