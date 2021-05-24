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
v_grad(1);
TS=zeros(1,n);

for i=1:1:n
    thetaonlsq=(0.45/ReL)*(ue(1,i))^(-6)*ueintbit(x(1,1),ue(1,1),x(1,i),ue(1,i));
    TS(1,i)=sqrt(thetaonlsq);
end

plot(x,TS);
hold on
BS=0.664/sqrt(ReL);
plot(x,BS.*sqrt(x));
xlabel('x/L')
ylabel('\theta/L')
legend('Thwaites’ solution','Blasius solution')

%test for trainsition
for i=1:1:n
    Rethet=ReL*ue(1,i)*TS(1,i);
    m=-ReL*(TS(1,i)^2)*v_grad(1,i);
    H = thwaites_lookup(m);
    He=laminar_He(H);
    
    if log(Rethet) >= 18.4*He - 21.74 
        laminar = false;
        disp([x(i) Rethet/1000])
    end
end


