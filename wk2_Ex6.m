clear;
close all;
global Re ue0 duedx


%Conditions for panels and flow
n = 101; % defines number of panels
laminar = true; % initializes boundary layer state flag 
ReL=1e4;
x = linspace(0,1,n);
duedx=-0.6; %velocity grad

%linearly varying ue/U
ue=linspace(1,1+duedx,n);

%define variables to store location of transition, separation, turbulent
%reattachment and turbulent separation
int=0;
ils=0;
itr=0;
its=0;

%defind the velocity gradient 
v_grad = duedx;


%initialise empty matrices to store results
TS=zeros(1,n);
He=zeros(1,n);
He(1,1)=1.57258; % define He at x/l=0
delta_E=zeros(1,n);


%start the laminar loop
i = 1;
while laminar && i < n
    %compute theta/L, Thwaites’ solution, Retheta
    thetaonlsq=(0.45/ReL)*(ue(1,i))^(-6)*ueintbit(x(1,1),ue(1,1),x(1,i),ue(1,i));
    TS(1,i)=sqrt(thetaonlsq); %Thwaites’ solution
    Rethet=ReL*ue(1,i)*TS(1,i);
    
    m=-ReL*(TS(1,i)^2)*v_grad;
    H = thwaites_lookup(m);
    He(1,i)=laminar_He(H);
    
    if log(Rethet) >= 18.4*He - 21.74 
        laminar = false;
        disp([x(i) Rethet/1000])
        int=i;
    elseif m>=0.09
        laminar = false;
        ils=i;
    end
    %second condition happens first means that separation happens before
    %trainsition and int will be zero, if int is non-zero then trainsition
    %happens first
    if int ~= 0
        disp(['Natural transition at ' num2str(x(int)) ...
                              ' with Rethet ' num2str(Rethet)])
    end
    
    if ils ~= 0
        disp(['Laminar separation at ' num2str(x(ils)) ...
                              ' with Rethet ' num2str(Rethet)]);
        He(1,i)=1.51509;%set to ls value
    end
    i = i + 1;
end

%initial conditions for turbulent loop
delta_E=sqrt(thetaonlsq)*He(1,i);
Re=ReL;


%start turbulent loop
while its==0 && i<n
    ue0=ue(1,i);
    thick0(1) = 0.023*x(1,i)*(Re*x(1,i))^(-1/6); %theta
    thick0(2) = delta_E; %delta_E
    [delx, thickhist] = ode45(@thickdash,[0,x(i)-x(i-1)],thick0);
    thick0(1)=thickhist(i,1);
    thick0(2)=thickhist(i,2);
end 

plot(x,TS);
hold on
BS=0.664/sqrt(ReL);
plot(x,BS.*sqrt(x));
xlabel('x/L')
ylabel('\theta/L')
legend('Thwaites’ solution','Blasius solution')
