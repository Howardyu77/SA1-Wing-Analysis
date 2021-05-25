function [int, ils, itr, its, delstar, theta] = bl_solv(x,cp)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
clear;
close all;
global Re ue0 duedx


%Conditions for panels and flow
n = 101; % defines number of panels
laminar = true; % initializes boundary layer state flag 
ReL=1e4;
duedx=-0.25; %velocity grad

%linearly varying ue/U
ue=linspace(1,1+duedx,n);

%define variables to store location of transition, separation, turbulent
%reattachment and turbulent separation
int=0;
ils=0;
itr=0;
its=0;

%initialise empty matrices to store results
He=zeros(1,n);
He(1,1)=1.57258; % define He at x/l=0
theta=zeros(1,n);

%start the laminar loop
i = 1;
while laminar && i < n
    i = i + 1;
    %compute theta/L, Retheta
    theta(i)=(0.45/ReL)*(ue(i))^(-6)*ueintbit(x(1),ue(1),x(i),ue(i));
    theta(i)=sqrt(theta(i));
    Rethet=ReL*ue(i)*theta(i);

    m=-ReL*(theta(i)^2)*duedx;
    H = thwaites_lookup(m);
    He(i)=laminar_He(H);
    
    if log(Rethet) >= 18.4*He(i) - 21.74 
        laminar = false;
        disp([x(i) Rethet/1000])
        int=i;
    elseif m>=0.09
        laminar = false;
        ils=i;
    end
end



if ils ~= 0
    He(1,i)=1.51509;%set to ls value
end


%initial conditions for turbulent loop from laminar loop output
delta_E=theta(i)*He(i);
Re=ReL;
thick0(1) = theta(1,i); %theta
thick0(2) = delta_E; %delta_E

%start turbulent loop, geting data from laminar loop output
while its==0 && i<n
    i = i + 1;
    ue0=ue(1,i);
    [delx, thickhist] = ode45(@thickdash,[0,x(i)-x(i-1)],thick0);
    %update theta and delta_E
    thick0(1)=thickhist(end,1);
    thick0(2)=thickhist(end,2);
    theta(1,i)=thickhist(end,1);
    He(1,i)=thick0(2)/thick0(1);% this
    
    
    %test for turbulent reattachment if it hasn't reattached
    if ils ~= 0  && itr==0
        if He(1,i)>1.58
            itr=i;   
        end
    end
    
    %test for turbulent separation
    if He(1,i)<1.46
        its=i;
    end 
    
end 

%separated turbulent boundary layer
while its~=0 && i<n
    i=i+1;
    theta(1,i)=(ue(1,i-1)/ue(1,i))^(2.803+2)*theta(1,i-1);
    He(1,i)=He(1,its);
end


end

