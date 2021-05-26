clear;
close all;
%define global variables
global Re ue0 duedx

Re=1e7;
ue0=1;
duedx=0;


%define intital values of theta and delta_E
x0 = 0.01;
thick0(1) = 0.023*x0*(Re*x0)^(-1/6); 
thick0(2) = 1.81*thick0(1);

[delx, thickhist] = ode45(@thickdash,[0 0.99],thick0);
x=delx+x0;

%power law estimates
theta_7=0.037.*x.*(Re.*x).^(-1/5);
theta_9=0.023.*x.*(Re.*x).^(-1/6);

plot(x,theta_7,'LineWidth',1.5);
hold on 
plot(x, theta_9,'LineWidth',1.5);
plot(x, thickhist(:,1),'LineWidth',1.5,'color',[0, 0.5, 0] );
legend({'\theta_7/L','\theta_9/L','Numerical solution'},'Location','northwest','FontSize',14);
ylabel('\theta/L','FontSize',14);
xlabel('x/L','FontSize',14)

