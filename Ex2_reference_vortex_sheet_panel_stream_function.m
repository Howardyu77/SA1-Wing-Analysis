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
gamma_a=3;
gamma_b=3;

% generate matrices xm, ym, infa, infb
for i=1:1:nx
    for j=1:1:ny
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        [infa(i,j),infb(i,j)] = refpaninf(del,xm(i,j),ym(i,j));
    end
end

%contour plots of infa and infb
c = -0.15:0.05:0.15;

contour(xm,ym,infa,c);
figure(1)
title('Plot of fa')
figure(2)
contour(xm,ym,infb,c);
title('Plot of fb')

%contour plot of streamfunction with gamma_a and gamma_b
figure(3)
contour(xm,ym, gamma_a*infa + gamma_b*infb, c);
title('Plot of Streamfunction using fa and fb')

%contour plot of discretised panel approximation
%find coordinates and strengths of point vortices
nv=100;
yc = 0;
xc =zeros(nv);
Gamma = zeros(nv);
for k=1:1:nv
    xc(k) = (del/nv)*(k-0.5);
    Gamma(k) = (gamma_a + (gamma_a-gamma_b)/nv * (k-0.5))*del/nv;
end

%find stramfunction by summing streamfuntions of all the point vortices
psi=zeros(nx,ny);
for k=1:1:nv
    for i=1:1:nx
        for j=1:1:ny
            xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
            ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
            psi_k(i,j) = psipv(xc(k),yc,Gamma(k),xm(i,j),ym(i,j));
        end
    end
    psi = psi + psi_k;
end

figure(4)
contour(xm,ym,psi,c);
title('Plot of Streamfunction using discretised panel')
%contour plot of approximated infa and infb
%calculate discretised I_0 and I_1
I_0_dis=zeros(nx,ny);
I_1_dis = zeros(nx,ny);
for k=1:1:nv
    for i=1:1:nx
        for j=1:1:ny
            I_0_dis_k(i,j) = psipv(xc(k),yc,1/nv,xm(i,j),ym(i,j));
            I_1_dis_k(i,j) = (xc(k)-xm(i,j))* psipv(xc(k),yc,1/nv,xm(i,j),ym(i,j));
        end
    end
    I_0_dis = I_0_dis + I_0_dis_k;
    I_1_dis = I_1_dis + I_1_dis_k;
end
%calculate discretised infa and infb
for i=1:1:nx
    for j=1:1:ny
        infa_dis(i,j) = (1-(xm(i,j)/del))*I_0_dis(i,j)-I_1_dis(i,j)/del;
        infb_dis(i,j) = (xm(i,j)/del)*I_0_dis(i,j)+I_1_dis(i,j)/del;
    end
end

%plot discretised infa and infb
figure(5)
contour(xm,ym,infa_dis,c);
title('Plot of fa using discretised panel')

figure(6)
contour(xm,ym,infb_dis,c);
title('Plot of fb using discretised panel')

figure(7)
contour(xm,ym,(gamma_a*infa_dis+ gamma_b*infb_dis),c);
title('Plot of streamfunction using discrete fa and fb')