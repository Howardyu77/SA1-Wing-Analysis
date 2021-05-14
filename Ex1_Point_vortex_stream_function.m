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
% preallocate matrices
xm=zeros(nx,ny);
ym=zeros(nx,ny);
psi=zeros(nx,ny);
% generatematrices xm, ym, psi
for i=1:1:nx
    for j=1:1:ny
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        psi(i,j) = psipv(xc,yc,Gamma,xm(i,j),ym(i,j));
    end
end


c = -0.4:0.2:1.2;

contour(xm,ym,psi,c);
xlabel('x');
ylabel('y');