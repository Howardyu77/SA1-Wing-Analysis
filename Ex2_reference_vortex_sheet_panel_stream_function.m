clear;
close all;

% Define variables, where nx and ny is the no. of point in x and y
nx = 51;
ny = 41;
xmin = -2.5;
xmax = 2.5;
ymin = -2.0;
ymax = 2.0;
del = 1.5;
% preallocate matrices
xm=zeros(nx,ny);
ym=zeros(nx,ny);
infa=zeros(nx,ny);
infb=zeros(nx,ny);
% generate matrices xm, ym, psi
for i=1:1:nx
    for j=1:1:ny
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        [infa(i,j),infb(i,j)] = refpaninf(del,xm(i,j),ym(i,j));
    end
end

% draw contour plots
c = -0.15:0.05:0.15;

contour(xm,ym,infa,c);

figure(2)
contour(xm,ym,infb,c);

%contourplot of streamfunction with gamma_a and gamma_b
gamma_a=2;
gamma_b=4;
figure(3)
contour(xm,ym, gamma_a*infa + gamma_b*infb, c);

%contour plot of discretised panel approximation
%find coordinates of point vortices
nv=100;
yc = 0;
xc =zeros(nv);
Gamma = zeros(nv);
for n=1:1:nv
    xc(n) = n*(del/nv)-0.5*(del/nv);
    Gamma(n) = gamma_a + (gamma_a-gamma_b)/del * xc(n)
end

%find stramfunction by summing streamfuntions of all the point vortices
psi=zeros(nx,ny);
for n=1:1:nv
    for i=1:1:nx
        for j=1:1:ny
            xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
            ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
            psi_n(i,j) = psipv(xc(n),yc,Gamma(n),xm(i,j),ym(i,j));
        end
    end
    psi = psi + psi_n;
end

figure(4)
contour(xm,ym,psi,c);

%approcimate infa and infb
