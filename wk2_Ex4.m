clear;
close all;

n = 101; % defines number of panels
laminar = true; % initializes boundary layer state flag 
ReL=1e4;
x = linspace(0,1,n);
n=length(x);
%linearly varying ue/U
ue=linspace(1,0.5,n);

%find the velocity gradient 
v_grad = gradient(ue,x);
v_grad(1);
TS=zeros(1,n);
i = 1;