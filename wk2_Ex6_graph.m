clear;
close all;
global Re ue0 duedx


%Conditions for panels and flow
n = 101; % defines number of panels
laminar = true; % initializes boundary layer state flag 
ReL=1e6;
x = linspace(0,1,n);
duedx=0; %velocity grad

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
    if ils ~= 0  && itr==0 && He(1,i)>1.58
        itr=i;   
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

%output
%second condition happens first means that separation happens before
    %trainsition and int will be zero, if int is non-zero then trainsition
    %happens first
% if int ~= 0
%     disp(['Natural transition at ' num2str(x(int)) ...
%         ' with Rethet ' num2str(Rethet)])
% end
% 
% if ils ~= 0
%     disp(['Laminar separation at ' num2str(x(ils)) ...
%         ' with Rethet ' num2str(Rethet)]);
% end
% 
% if itr~=0
%     disp(['Turbulent reattachment at ' num2str(x(itr))]);
% end
% 
% if its~=0
%     disp(['Turbulent separation at ' num2str(x(its))]);
% end

theta1=theta;
He1=He;
ils1=ils;
int1=int;
itr1=itr;
its1=its;

%Conditions for panels and flow
n = 101; % defines number of panels
laminar = true; % initializes boundary layer state flag 
ReL=1e7;
x = linspace(0,1,n);
duedx=0; %velocity grad

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
    if ils ~= 0  && itr==0 && He(1,i)>1.58
        itr=i;   
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
theta2=theta;
He2=He;
ils2=ils;
int2=int;
itr2=itr;
its2=its;
% %Conditions for panels and flow
% n = 101; % defines number of panels
% laminar = true; % initializes boundary layer state flag 
% ReL=1e6;
% x = linspace(0,1,n);
% duedx=-0.25; %velocity grad
% 
% %linearly varying ue/U
% ue=linspace(1,1+duedx,n);
% 
% %define variables to store location of transition, separation, turbulent
% %reattachment and turbulent separation
% int=0;
% ils=0;
% itr=0;
% its=0;
% 
% %initialise empty matrices to store results
% He=zeros(1,n);
% He(1,1)=1.57258; % define He at x/l=0
% theta=zeros(1,n);
% 
% %start the laminar loop
% i = 1;
% while laminar && i < n
%     i = i + 1;
%     %compute theta/L, Retheta
%     theta(i)=(0.45/ReL)*(ue(i))^(-6)*ueintbit(x(1),ue(1),x(i),ue(i));
%     theta(i)=sqrt(theta(i));
%     Rethet=ReL*ue(i)*theta(i);
% 
%     m=-ReL*(theta(i)^2)*duedx;
%     H = thwaites_lookup(m);
%     He(i)=laminar_He(H);
%     
%     if log(Rethet) >= 18.4*He(i) - 21.74 
%         laminar = false;
%         disp([x(i) Rethet/1000])
%         int=i;
%     elseif m>=0.09
%         laminar = false;
%         ils=i;
%     end
% end
% 
% 
% 
% if ils ~= 0
%     He(1,i)=1.51509;%set to ls value
% end
% 
% 
% %initial conditions for turbulent loop from laminar loop output
% delta_E=theta(i)*He(i);
% Re=ReL;
% thick0(1) = theta(1,i); %theta
% thick0(2) = delta_E; %delta_E
% 
% %start turbulent loop, geting data from laminar loop output
% while its==0 && i<n
%     i = i + 1;
%     ue0=ue(1,i);
%     [delx, thickhist] = ode45(@thickdash,[0,x(i)-x(i-1)],thick0);
%     %update theta and delta_E
%     thick0(1)=thickhist(end,1);
%     thick0(2)=thickhist(end,2);
%     theta(1,i)=thickhist(end,1);
%     He(1,i)=thick0(2)/thick0(1);% this
%     
%     
%     %test for turbulent reattachment if it hasn't reattached
%     if ils ~= 0  && itr==0 && He(1,i)>1.58
%         itr=i;   
%     end
%     
%     %test for turbulent separation
%     if He(1,i)<1.46
%         its=i;
%     end 
%     
% end 
% 
% %separated turbulent boundary layer
% while its~=0 && i<n
%     i=i+1;
%     theta(1,i)=(ue(1,i-1)/ue(1,i))^(2.803+2)*theta(1,i-1);
%     He(1,i)=He(1,its);
% end
% theta3=theta;
% He3=He;
% ils3=ils;
% int3=int;
% itr3=itr;
% its3=its;

figure(1)
plot(x,theta1,'-.','LineWidth',2);
hold on
plot(x,theta2,'--','LineWidth',2);
% plot(x,theta3,':','LineWidth',2);
plot(x(int2),theta2(int2),'.','MarkerSize',20,'LineWidth',2);
% plot(x(ils1),theta1(ils1),'*','color',[0.3010, 0.7450, 0.9330],'MarkerSize',10,'LineWidth',1.5,'HandleVisibility','off');
% plot(x(ils2),theta2(ils2),'*','color',[0.3010, 0.7450, 0.9330],'MarkerSize',10,'LineWidth',1.5);
% plot(x(itr2),theta2(itr2),'o','MarkerSize',10,'LineWidth',1.5);
% plot(x(its1),theta1(its1),'+','MarkerSize',10,'LineWidth',1.5);
% 
hold off
xlabel('x/L','FontSize',14)
ylabel('\theta/L','FontSize',14)
% legend({'Re_L=10^4','Re_L=10^5','Re_L=10^6','Natural transition','Laminar separation','Turbulent reattachment','Turbulent separation'},'Location', 'Best','FontSize',14) 
legend({'Re_L=10^6','Re_L=10^7','Natural transition'},'Location', 'Best','FontSize',14)
% 
 figure(2)
 plot(x,He1,'-.','LineWidth',2);
 hold on
 plot(x,He2,'--','LineWidth',2);
% plot(x,He3,':','LineWidth',2);
 plot(x(int2),He2(int2),'.','MarkerSize',20,'LineWidth',2);
% plot(x(ils1), He1(ils1),'*','MarkerSize',8,'LineWidth',1.5,'HandleVisibility','off');
% plot(x(ils2), He1(ils2),'*','MarkerSize',8,'LineWidth',1.5);
% plot(x(itr2),He2(itr2),'o','MarkerSize',10,'LineWidth',1.5);
% plot(x(its1),He1(its1),'+','MarkerSize',10,'LineWidth',1.5);
% % n1=0.485;
% % n2=0.502;
% % m1=1.51;
% % m2=1.525;
% % n=[n1,n2,n2,n1,n1];
% % m=[m1,m1,m2,m2,m1];
% % plot(n,m)
% hold off
 xlabel('x/L','FontSize',14)
 ylabel('H_e/L','FontSize',14)
% legend({'Re_L=10^4','Re_L=10^5','Re_L=10^6','Natural transition','Laminar separation','Turbulent reattachment','Turbulent separation'},'Location', 'Best','FontSize',14)
legend({'Re_L=10^6','Re_L=10^7','Natural transition'},'Location', 'Best','FontSize',14)
% if ils~=0
%     if its~=0 %laminar separation and reattachment
%         plot(x,theta1,'LineWidth',2);
%         hold on
%         plot(x,theta2,'LineWidth',2);
%         plot(x(ils1),theta1(ils1),x(ils2),theta2(ils2),'*','color',[0.9290, 0.6940, 0.1250],'MarkerSize',10,'LineWidth',1.5,'HandleVisibility','off');
%         plot(x(itr1),theta1(itr1),x(itr2),theta2(itr2),'o','MarkerSize',10,'LineWidth',1.5,'HandleVisibility','off');
%         plot(x(its1),theta1(its1),x(its2),theta2(its2),'+','MarkerSize',10,'LineWidth',1.5,'HandleVisibility','off');
%         hold off
%         xlabel('x/L','FontSize',14)
%         ylabel('\theta/L','FontSize',14)
%         legend({'Laminar separation','Turbulent reattachment','Turbulent separation'},'Location', 'Best','FontSize',14)
% 
%         figure(2)
%         plot(x,theta1,'LineWidth',2);
%         hold on
%         plot(x,theta2,'LineWidth',2);
%         plot(x(ils1),theta1(ils1),x(ils2),theta2(ils2),'*','MarkerSize',10,'LineWidth',1.5,'HandleVisibility','off');
%         plot(x(itr1),theta1(itr1),x(itr2),theta2(itr2),'o','MarkerSize',10,'LineWidth',1.5,'HandleVisibility','off');
%         plot(x(its1),theta1(its1),x(its2),theta2(its2),'+','MarkerSize',10,'LineWidth',1.5,'HandleVisibility','off');
%         hold off
%         xlabel('x/L','FontSize',14)
%         ylabel('H_e/L','FontSize',14)
%         legend({'Laminar separation','Turbulent reattachment','Turbulent separation'},'Location', 'Best','FontSize',14)
%     else
%         plot(x,theta1,'LineWidth',2);
%         hold on
%         plot(x,theta2,'LineWidth',2);
%         plot(x(ils1),theta1(ils1),x(ils2),theta2(ils2),'*','MarkerSize',10,'LineWidth',1.5,'HandleVisibility','off');
%         plot(x(itr1),theta1(itr1),x(itr2),theta2(itr2),'o','MarkerSize',10,'LineWidth',1.5,'HandleVisibility','off');
%         hold off
%         xlabel('x/L','FontSize',14)
%         ylabel('\theta/L','FontSize',14)
%         legend({'Laminar separation','Turbulent reattachment',},'Location', 'Best','FontSize',14)
% 
%         figure(2)
%         plot(x,He,'LineWidth',2, 'HandleVisibility','off');
%         hold on
%         plot(x(ils),He(ils),'*','MarkerSize',10,'LineWidth',1.5);
%         plot(x(itr),He(itr),'o','MarkerSize',8,'LineWidth',1.5);
%         hold off
%         xlabel('x/L','FontSize',14)
%         ylabel('H_e/L','FontSize',14)
%         legend({'Laminar separation','Turbulent reattachment'},'Location', 'Best','FontSize',14)
%     end
% else
%     if its~=0
%         plot(x,theta,'LineWidth',2, 'HandleVisibility','off');
%         hold on
%         plot(x(int),theta(int),'.','MarkerSize',10,'LineWidth',1.5);
%         plot(x(its),theta(its),'+','MarkerSize',10,'LineWidth',1.5);
%         hold off
%         xlabel('x/L','FontSize',14)
%         ylabel('\theta/L','FontSize',14)
%         legend({'Natural transition','Turbulent separation'},'Location', 'Best','FontSize',14)
% 
%         figure(2)
%         plot(x,He,'LineWidth',2, 'HandleVisibility','off');
%         hold on
%         plot(x(int),He(int),'.','MarkerSize',10,'LineWidth',1.5);
%         plot(x(its),He(its),'+','MarkerSize',10,'LineWidth',1.5);
%         hold off
%         xlabel('x/L','FontSize',14)
%         ylabel('H_e/L','FontSize',14)
%        legend({'Natural transition','Turbulent separation'},'Location', 'Best','FontSize',14)
%     else
%         plot(x,theta,'LineWidth',2,'HandleVisibility','off');
%         hold on
%         plot(x(int),theta(int),'.','MarkerSize',10,'LineWidth',1.5);
%         hold off
%         xlabel('x/L','FontSize',14)
%         ylabel('\theta/L','FontSize',14)
%         legend({'Natural transition'},'Location', 'Best','FontSize',14)
% 
%         figure(2)
%         plot(x,He,'LineWidth',2, 'HandleVisibility','off');
%         hold on
%         plot(x(int),He(int),'.','MarkerSize',10,'LineWidth',1.5);
%         hold off
%         xlabel('x/L','FontSize',14)
%         ylabel('H_e/L','FontSize',14)
%         legend({'Natural transition'},'Location', 'Best','FontSize',14)
%     end
% end