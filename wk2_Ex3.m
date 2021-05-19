clear;
close all;

n = 101; % defines number of panels
laminar = true; % initializes boundary layer state flag 
ReL=1.794e6;
x = linspace(0,1,n);
n=length(x);
%linearly varying ue/U
ue=linspace(1,0.5,n);
%define variables to store location of transition or separation
int=0;
ils=0;
%find the pressure gradient 
p_grad = gradient(ue,x);
p_grad(1);
TS=zeros(1,n);
i = 1;
while laminar && i < n
    
    thetaonlsq=(0.45/ReL)*(ue(1,i))^(-6)*ueintbit(x(1,1),ue(1,1),x(1,i),ue(1,i));
    TS(1,i)=sqrt(thetaonlsq);
     Rethet=ReL*ue(1,i)*TS(1,i);
    
    m=-ReL*(TS(1,i)^2)*p_grad(1,i);
    H = thwaites_lookup(m);
    He=laminar_He(H);
    
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
    i = i + 1;
end


plot(x,TS);
hold on
BS=0.664/sqrt(ReL);
plot(x,BS.*sqrt(x));
xlabel('x/L')
ylabel('\theta/L')
legend('Thwaites’ solution','Blasius solution')
