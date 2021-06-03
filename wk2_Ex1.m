clear;
close all;

%define Reynolds number, create vectors
ReL=2500;
x = linspace(0,1,101);
n=length(x);
%for zero-pressure-gradient b'layer
ue=ones(1,n);

theta=zeros(1,n);
integral=0;
for i=2:1:n
    integral=integral + ueintbit(x(i-1),ue(i-1),x(i),ue(i));
    theta(i)=(0.45/ReL)*(ue(i))^(-6)*integral;
    theta(i)=sqrt(theta(i));
end

plot(x,theta,'LineWidth',1.5);
hold on
plot(x,(0.664/sqrt(ReL)).*sqrt(x),'LineWidth',1.5);
xlabel('x/L','FontSize',14)
ylabel('\theta/L','FontSize',14)
legend({'Thwaites’ solution','Blasius solution'},'Location','northwest','FontSize',14);
