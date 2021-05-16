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
gamma_a=1;
xb=2.2;
yb=2.9;
gamma_b=1;

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

%contour plot of streamfunction with gamma_a and gamma_b
c = -0.15:0.05:0.15;
figure(1)
contour(xm,ym,infa,c);
title('Plot of fa');
xlabel('x');
ylabel('y');

figure(2)
contour(xm,ym,infb,c);
title('Plot of fb');
xlabel('x');
ylabel('y');

%contour plot of discretised panel approximation
%find coordinates and strengths of point vortices
%Preallocating matrices
nv=100;
yc =zeros(nv);
xc =zeros(nv);
Gamma = zeros(nv);
del = sqrt((xb-xa)^2+(yb-ya)^2);

for k=1:1:nv
    xc(k) = xa + (k-0.5)*((xb-xa)/nv);
    yc(k) = ya + (k-0.5)*((yb-ya)/nv);
end


%contour plot of approximated infa and infb
%calculate discretised I_0 and I_1
I0_dis =zeros(nx,ny);
I1_dis = zeros(nx,ny);
for k=1:1:nv
    for i=1:1:nx
        for j=1:1:ny
            I0_dis_k(i,j) = psipv(xc(k),yc(k),1/nv,xm(i,j),ym(i,j));
            I1_dis_k(i,j) = (xc(k)-xm(i,j))* psipv(xc(k),yc(k),1/nv,xm(i,j),ym(i,j));
        end
    end
    I0_dis = I0_dis + I0_dis_k;
    I1_dis = I1_dis + I1_dis_k;
end
%calculate discretised infa and infb
for i=1:1:nx
    for j=1:1:ny
        infa_dis(i,j) = (1-(xm(i,j)/del))*I0_dis(i,j)-I1_dis(i,j)/del;
        infb_dis(i,j) = (xm(i,j)/del)*I0_dis(i,j)+I1_dis(i,j)/del;
    end
end

%plot discretised infa and infb
figure(3)
contour(xm,ym,infa_dis,c);
title('Plot of fa using discretised panel')
xlabel('x');
ylabel('y');

figure(4)
contour(xm,ym,infb_dis,c);
title('Plot of fb using discretised panel')
xlabel('x');
ylabel('y');




