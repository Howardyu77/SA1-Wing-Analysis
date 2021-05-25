clear;
close all;

%define Reynolds number, create vectors
ReL=2500;
x = linspace(0,1,101);
n=length(x);
%for zero-pressure-gradient b'layer
ue=ones(1,n);

TS=zeros(1,n);

for i=1:1:n
    thetasq=(0.45/ReL)*(ue(1,i))^(-6)*ueintbit(x(1,1),ue(1,1),x(1,i),ue(1,i));
    TS(1,i)=sqrt(thetasq);
end

plot(x,TS,'LineWidth',1.5);
hold on
plot(x,(0.664/sqrt(ReL)).*sqrt(x),'LineWidth',1.5);
xlabel('x/L','FontSize',14)
ylabel('\theta/L','FontSize',14)
legend({'Thwaites’ solution','Blasius solution'},'Location','northwest','FontSize',14);