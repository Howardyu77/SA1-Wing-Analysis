clear;
close all;

n = 101; % defines number of panels
laminar = true; % initializes boundary layer state flag 
ReL=1e6;%change acrodingly
x = linspace(0,1,n);
%linearly varying ue/U
ue=linspace(1,.9,n);%change acrodingly
%find the velocity gradient 
v_grad = gradient(ue,x);

theta=zeros(1,n);

i = 1;
integral=0;
while laminar && i < n
    i = i + 1;
    integral=integral + ueintbit(x(i-1),ue(i-1),x(i),ue(i));
    %compute theta/L, Thwaites’ solution, Retheta
    theta(i)=(0.45/ReL)*(ue(i))^(-6)*integral;
    theta(i)=sqrt(theta(i));%Thwaites’ solution
    Rethet=ReL*ue(i)*theta(i);
    
    m=-ReL*(theta(i)^2)*v_grad(i);
    H = thwaites_lookup(m);
    He=laminar_He(H);
    
    if log(Rethet) >= 18.4*He - 21.74 
        laminar = false;
        disp([x(i) Rethet/1000])
    end
end


plot(x,theta);
hold on
BS=0.664/sqrt(ReL);
plot(x,BS.*sqrt(x));
xlabel('x/L')
ylabel('\theta/L')
legend('Thwaites’ solution','Blasius solution')
