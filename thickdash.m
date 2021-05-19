function dthickdx = thickdash(xmx0,thick)
%UNTITLED26 Summary of this function goes here
%   Detailed explanation goes here
global ReL ue0 duedx

theta=thick(1,1);
delta_E=thick(2,1);
m = - theta^2/nu*duedx
H = thwaites_lookup(m)
if He>=1.46
    H=(11*He+15)/(48*He-59);
else
    H=2.803;
end
c_f=0.091416*((H-1)*Retheta)^-0.232*exp(-1.26*H);
c_diss=0.010011*((H-1)*Retheta)^(-1/6);



end

