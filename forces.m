function [cl, cd] = forces(circ,cp,delstarl,thetal,delstaru,thetau)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
cl=-2*circ;
%last points in the arrays are te
H_te_u=delstaru(end)/thetau(end); 
H_te_l=delstarl(end)/thetal(end);

ue_te= sqrt(1-cp(end));



theta_inf_u=thetau(end)*ue_te^((H_te_u+5)/2);
theta_inf_l=thetal(end)*ue_te^((H_te_l+5)/2);

cd=2*(theta_inf_u+theta_inf_l); %here chord length c is 1 and combine contributions from both surfaces
end

