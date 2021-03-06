clear;
close all;
tic
%define the cylinerical panels
np=100;
theta = (0:np)*2*pi/np;
xs = cos(theta);
ys = sin(theta);
gammas = -2*sin(theta);

%flow condition at alpha=0
alpha=0;
A = build_lhs(xs,ys);
b = build_rhs(xs,ys,alpha); 
gam = A\b;

%total circulation 
%arc length of the panels on a unit circle
arc_length = 2*pi*(2*pi/np);
Gamma=0;
for i=1:1:length(gam)
    Gamma = gam(i)*arc_length + Gamma;
end 
figure(1)
plot(theta/pi,gam)

axis([0 2 -2.5 2.5])

%flow condition at alpha=pi/15
alpha=pi/15;

A = build_lhs(xs,ys);

b = build_rhs(xs,ys,alpha); 
gam = A\b;

%total circulation 
%arc length of a unit circle
arc_length = 2*pi/np;
Gamma=0;
for i=1:1:length(gam)
    Gamma = gam(i)*arc_length + Gamma;
end 

Gamma;

hold on
plot(theta/pi,gam)
set(gca,'FontSize',16)
xlabel("\theta/\pi")
ylabel("\gamma")
%title('Plots of surface velocity');
axis([0 2 -2.5 2.5])
legend('\alpha=0','\alpha=\pi/15')
toc