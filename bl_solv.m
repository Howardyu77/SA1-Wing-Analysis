function [int, ils, itr, its, delstar, theta] = bl_solv(x,cp)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global Re ue0 duedx


%Conditions for panels and flow
n = length(x); % defines number of panels from length x
laminar = true; % initializes boundary layer state flag 


%define variables to store location of transition, separation, turbulent
%reattachment and turbulent separation
int=0;
ils=0;
itr=0;
its=0;

%initialise empty matrices to store results
He=zeros(1,n);
delstar=zeros(1,n);
theta=zeros(1,n);
ue=zeros(1,n);
%inital conditions

%calculate ue,duedx
ue(1)=sqrt(1-cp(1));
duedx=(ue(1)-0)/(x(1)-0);
%compute theta/L, Retheta
theta(1)=(0.45/Re)*(ue(1))^(-6)*ueintbit(0,0,x(1),ue(1));%x=0,ue=0 at stag condition
theta(1)=sqrt(theta(1));
m=-Re*(theta(1)^2)*duedx;
H = thwaites_lookup(m);
delstar(1)=H*theta(1);
He(1)=laminar_He(H);

%start the laminar loop
i = 2;
while laminar && i < n
    i = i + 1;
    %calculate ue,duedx
    ue(i)=sqrt(1-cp(i));
    duedx=(ue(i)-ue(i-1))/(x(i)-x(i-1));
    
    %compute theta/L, Retheta
    theta(i)=(0.45/Re)*(ue(i))^(-6)*ueintbit(0,0,x(i),ue(i));%x=0,ue=0 at stag condition
    theta(i)=sqrt(theta(i));
    Rethet=Re*ue(i)*theta(i);

    m=-Re*(theta(i)^2)*duedx;
    H = thwaites_lookup(m);
    delstar(i)=H*theta(i);
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
thick0(1) = theta(1,i); %theta
thick0(2) = delta_E; %delta_E

%start turbulent loop, geting data from laminar loop output
while its==0 && i<n
    i = i + 1;
    %calculate ue,duedx
    ue(i)=sqrt(1-cp(i));
    duedx=(ue(i)-ue(i-1))/(x(i)-x(i-1));
    
    ue0=ue(i);
    [delx, thickhist] = ode45(@thickdash,[0,x(i)-x(i-1)],thick0);
    %update theta and delta_E
    thick0(1)=thickhist(end,1);
    thick0(2)=thickhist(end,2);
    theta(i)=thickhist(end,1);
    He(i)=thick0(2)/thick0(1);% this
    H=(11*He(i)+15)/(48*He(i)-59);
    delstar(i)=theta(i)*H;
    
    %test for turbulent reattachment if it hasn't reattached
    if ils ~= 0  && itr==0
        if He(i)>1.58
            itr=i;   
        end
    end
    
    %test for turbulent separation
    if He(i)<1.46
        its=i;
    end 
    
end 

%separated turbulent boundary layer
while its~=0 && i<n
    i=i+1;
    %calculate ue,duedx
    ue(i)=sqrt(1-cp(i));
    duedx=(ue(i)-ue(i-1))/(x(i)-x(i-1));
    
    theta(i)=(ue(i-1)/ue(i))^(2.803+2)*theta(i-1);
    He(i)=He(its);
    H=(11*He(i)+15)/(48*He(i)-59);
    delstar(i)=theta(i)*H;
end
end

