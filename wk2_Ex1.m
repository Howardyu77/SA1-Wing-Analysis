clear;
close all;

%define Reynolds number, create vectors
ReL=2500;
x = linspace(0,1,101);
n=length(x);
%for zero-pressure-gradient b'layer
ue=ones(n,1);

TS=zeros(n,1);

for i=1:1:n
    thetasq=(0.45/ReL)*(ue(i,1))^(-6)*ueintbit(x(1,1),ue(1,1),x(1,i),ue(i,1));
    TS(i,1)=sqrt(thetasq);
end

plot(x,TS);
hold on
plot(x,(0.664/sqrt(ReL)).*sqrt(x));
xlabel('x/L')
ylabel('\theta/L')
legend('Thwaites’ solution','Blasius solution')