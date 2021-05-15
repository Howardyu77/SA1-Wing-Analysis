clear;
close all;

% Define variables, where nx and ny is the no. of point in x and y
nx = 51;
ny = 41;
xmin = 0;
xmax = 5;
ymin = 0;
ymax = 4;

xa=4.1;
ya=1.6;
gamma_a=3;
xb=2.2;
yb=2.9;
gamma_b=3;

% generate matrices xm, ym, infa, infb
for i=1:1:nx
    for j=1:1:ny
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        [infa(i,j),infb(i,j)] = panelinf(xa,ya,xb,yb,xm(i,j),ym(i,j));
    end
end

%contour plot of streamfunction with gamma_a and gamma_b
c = -0.15:0.05:0.15;
figure(1)
contour(xm,ym, gamma_a*infa + gamma_b*infb, c);
title('Plot of Streamfunction using fa and fb');

%contour plot of discretised panel approximation
%find coordinates and strengths of point vortices
nv=100;
yc =zeros(nv);
xc =zeros(nv);
Gamma = zeros(nv);
del = sqrt((xb-xa)^2+(yb-ya)^2);
for k=1:1:nv
    xc(k) = xa + (k-0.5)*((xb-xa)/nv);
    yc(k) = ya + (k-0.5)*((yb-ya)/nv);
    Gamma(k) = (gamma_a + (gamma_a-gamma_b)/nv *(k-0.5))*del/nv;
end

%find stramfunction by summing streamfuntions of all the point vortices
psi=zeros(nx,ny);
for k=1:1:nv
    for i=1:1:nx
        for j=1:1:ny
            psi_k(i,j) = psipv(xc(k),yc(k),Gamma(k),xm(i,j),ym(i,j));
        end
    end
    psi = psi + psi_k;
end

figure(2)
contour(xm,ym,psi,c);
title('Plot of Streamfunction using discretised point vortices')




