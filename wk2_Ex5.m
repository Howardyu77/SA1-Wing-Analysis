clear;
close all;
%define global variables
global Re ue0 duedx
n = 101; % defines number of panels


Re=1e7;
ue0=1;
duedx=-0.6;


%define intital values of theta and delta_E
x0 = 0.01;
thick0(1) = 0.023*x0*(Re*x0)^(-1/6); 
thick0(2) = 1.81*thick0(1);

[delx, thickhist] = ode45(@thickdash,[0 0.99],thick0);
x=delx+x0;

%power law estimates
theta_7=0.037.*x.*(Re.*x).^(-1/5);
theta_9=0.023.*x.*(Re.*x).^(-1/6);

He=thickhist(:,2)./thickhist(:,1);



plot(x, thickhist(:,1));
hold on 
plot(x, thickhist(:,2));
legend({'\theta/L','\delta_E/L'},'Location','northwest','FontSize',14);
ylabel('\theta/L');
xlabel('x/L')
title('Non-dimensionalised thickness plot')

figure(2)
plot(x, He);
hold on 
threshold=1.46.*ones(length(x));
plot(x,threshold);
xlabel('x/L')
ylabel('H_e/L')
legend('Energy shape factor','Threshold for turbulent separation')
title('Energy shape factor plot')
