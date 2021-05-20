function dthickdx = thickdash(xmx0,thick)
%UNTITLED26 Summary of this function goes here
%   Detailed explanation goes here
global Re ue0 duedx %ReL, free-stream velocity, velocity gradient (non-dimensional)

theta=thick(1,1);
delta_E=thick(2,1);


ue=ue0+duedx*xmx0;
Retheta=Re*ue*theta;%meant to be theta/L 

He=delta_E/theta;
if He>=1.46
    H=(11*He+15)/(48*He-59);
else
    H=2.803;
end
c_f=0.091416*((H-1)*Retheta)^-0.232*exp(-1.26*H);
c_diss=0.010011*((H-1)*Retheta)^(-1/6);


dthickdx=zeros(2,1);
dthickdx(1,1)=(c_f/2)-((H+2)/ue) * duedx * theta;
dthickdx(2,1)=c_diss-3/ue * duedx * delta_E;
end

