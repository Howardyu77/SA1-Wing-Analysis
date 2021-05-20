clear;
close all;

n = 101; % defines number of panels 

Re=1e4;
ue0=1;
duedx=0;
x = linspace(0,1,n);
n=length(x);
%linearly varying ue/U
ue=linspace(1,0.5,n);

%find the velocity gradient 
ndduedx = gradient(ue,x);
ndduedx(1);
TS=zeros(1,n);
i = 1;
%define intital values of theta and delta_E
x0 = 0.01;
thick0(1) = 0.023*x0*(Re*x0)^(-1/6); 
thick0(2) = 1.81*thick0(1);

[delx, thickhist] = ode45(@thickdash,[0 0.99],thick0);

theta_7=0.037*x*(Re*x)^-1/5;
theta_9=0.023*x*(Re*x)^-1/6;

Plot(x,theta_7)

