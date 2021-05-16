clear;
close all;

% Define variables, where nx and ny is the no. of point in x and y
nx = 51;
ny = 41;
xmin = -2.5;
xmax = 2.5;
ymin = -2;
ymax = 2;
%Preallocating matrices
xm=zeros(nx,ny);
ym=zeros(nx,ny);
psi=zeros(nx,ny);
psi_k=zeros(nx,ny);
infa=zeros(nx,ny);
infb=zeros(nx,ny);
%define the cylinerical panels
np=100;
theta = (0:np)*2*pi/np;
gamma = -2*sin(theta);

%Preallocating matrices
xs=zeros(np+1);
ys=zeros(np+1);
gammas=zeros(np+1);

for i=1:1:np+1
    xs(i) = cos(theta(i));
	ys(i) = sin(theta(i));
end


% generate matrices xm, ym
for i=1:1:nx
    for j=1:1:ny
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        psi(i,j) = ym(i,j);
    end
end

%calculate streamfunction
for k=1:1:np
    for i=1:1:nx
        for j=1:1:ny
           [infa(i,j),infb(i,j)] = panelinf(xs(k),ys(k),xs(k+1),ys(k+1),xm(i,j),ym(i,j));
           psi_k(i,j) =  gamma(k)*infa(i,j) + gamma(k+1)*infb(i,j);
        end
    end
    psi = psi + psi_k;
end


c = -1.75:0.25:1.75;
figure(1)
contour(xm,ym,psi,c);
hold on
plot(xs,ys)
hold off 
title('Plot of Streamfunction using fa and fb');

