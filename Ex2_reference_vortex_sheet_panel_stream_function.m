clear;
close all;

% Define variables, where nx and ny is the no. of point in x and y
nx = 51;
ny = 41;
xmin = -2.5;
xmax = 2.5;
ymin = -2.0;
ymax = 2.0;
xc = 0.75;
yc = 0.5;
Gamma = 3.0;
del = 1.5;
nv=100;
% preallocate matrices
xm=zeros(nx,ny);
ym=zeros(nx,ny);
psi=zeros(nx,ny);
infa=zeros(nx,ny);
infb=zeros(nx,ny);
% generate matrices xm, ym, psi
for i=1:1:nx
    for j=1:1:ny
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        psi(i,j) = psipv(xc,yc,Gamma,xm(i,j),ym(i,j));
        [infa(i,j),infb(i,j)] = refpaninf(del,xm(i,j),ym(i,j));
    end
end

% draw contour plots
c = -0.15:0.05:0.15;

contour(xm,ym,infa,c);
xlabel('x');
ylabel('y');

figure(2)
contour(xm,ym,infb,c);
xlabel('x');
ylabel('y');
box on
print -deps2c figure_name.eps