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
xb=2.2;
yb=2.9;


%Preallocating matrices
xm=zeros(nx,ny);
ym=zeros(nx,ny);
infa=zeros(nx,ny);
infb=zeros(nx,ny);


% generate matrices xm, ym, infa, infb
for i=1:1:nx
    for j=1:1:ny
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        [infa(i,j),infb(i,j)] = panelinf(xa,ya,xb,yb,xm(i,j),ym(i,j));
    end
end

c = -0.15:0.05:0.15;
figure(1)
contour(xm,ym,infa,c);
%title('Plot of fa');
xlabel('x');
ylabel('y');

figure(2)
contour(xm,ym,infb,c);
%title('Plot of fb');
xlabel('x');
ylabel('y');

%contour plot of approximate fa
nv=100;
yc =zeros(nv);
xc =zeros(nv);
Gamma = zeros(nv);
del = sqrt((xb-xa)^2+(yb-ya)^2);
gamma_a=1;
gamma_b=0;

for k=1:1:nv
    xc(k) = xa + (k-0.5)*((xb-xa)/nv);
    yc(k) = ya + (k-0.5)*((yb-ya)/nv);
    Gamma(k) = (gamma_a + (gamma_b-gamma_a)/nv * (k-0.5))*del/nv;
end

psi=zeros(nx,ny);
psi_k=zeros(nx,ny);
for k=1:1:nv
    for i=1:1:nx
        for j=1:1:ny
            xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
            ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
            psi_k(i,j) = psipv(xc(k),yc(k),Gamma(k),xm(i,j),ym(i,j));
        end
    end
    psi = psi + psi_k;
end
infa_dis = psi;

figure(3)
contour(xm,ym,infa_dis,c);
%title('Plot of fa using discretised panel')
xlabel('x');
ylabel('y');

%Contour plot of approxiamte fb
gamma_a=0;
gamma_b=1;

for k=1:1:nv
    xc(k) = xa + (k-0.5)*((xb-xa)/nv);
    yc(k) = ya + (k-0.5)*((yb-ya)/nv);
    Gamma(k) = (gamma_a + (gamma_b-gamma_a)/nv * (k-0.5))*del/nv;
end

psi=zeros(nx,ny);
psi_k=zeros(nx,ny);
for k=1:1:nv
    for i=1:1:nx
        for j=1:1:ny
            xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
            ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
            psi_k(i,j) = psipv(xc(k),yc(k),Gamma(k),xm(i,j),ym(i,j));
        end
    end
    psi = psi + psi_k;
end
infb_dis = psi;

figure(4)
contour(xm,ym,infb_dis,c);
%title('Plot of fb using discretised panel')
xlabel('x');
ylabel('y');




