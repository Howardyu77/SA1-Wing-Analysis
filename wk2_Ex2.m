clear;
close all;

%define Reynolds number, create vectors
ReL=2e6;
x = linspace(0,1,101);
n=length(x);
%linearly varying ue/U
ue=linspace(1,0.9,101);
%find the velocity gradient 
v_grad = gradient(ue,x);

theta=zeros(1,n);

for i=1:1:n
    theta(i)=(0.45/ReL)*(ue(1,i))^(-6)*ueintbit(x(1),ue(1),x(i),ue(i));
    theta(i)=sqrt(theta(i));
end

plot(x,theta);
hold on
BS=0.664/sqrt(ReL);
plot(x,BS.*sqrt(x));
xlabel('x/L')
ylabel('\theta/L')
legend('Thwaites’ solution','Blasius solution')

%test for trainsition
for i=1:1:n
    Rethet=ReL*ue(i)*theta(i);
    m=-ReL*(theta(i)^2)*v_grad(i);
    H = thwaites_lookup(m);
    He=laminar_He(H);
    
    if log(Rethet) >= 18.4*He - 21.74 
        laminar = false;
        disp([x(i) Rethet/1000])
    end
end


