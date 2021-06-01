%    foil.m
%
%  Script to analyse an aerofoil section using potential flow calculation
%  and boundary layer solver.
%

clear all



%  Read in the parameter file
caseref = 'tryout';
parfile = ['Parfiles/' caseref '.txt'];
fprintf(1, '%s\n\n', ['Reading in parameter file: ' parfile])
[section1 np Re1 alpha] = par_read(parfile);
%  Read in the parameter file
caseref = 'tryout1'
parfile = ['Parfiles/' caseref '.txt'];
fprintf(1, '%s\n\n', ['Reading in parameter file: ' parfile])
[section1 np Re2 alpha] = par_read(parfile);




[xs, ys, alpha,cp1, clswp1, cdswp1, lovdswp1,gam1] = foil_function('tryout');

[xs, ys, alpha,cp2, clswp2, cdswp2, lovdswp2,gam2] = foil_function('tryout1');

str1='Re=' + string(sprintf('%1.2e',Re1));
str2='Re=' + string(sprintf('%1.2e',Re2));
%%Post processing
figure(1)
plot(alpha,clswp1,'-*','LineWidth',1.5)
hold on
plot(alpha,clswp2,':x','LineWidth',1.5)
hold off
xlabel('\alpha','FontSize',14)
ylabel('C_L','FontSize',14)
legend({str1,str2},'Location','best','FontSize',14)
title('C_L vs \alpha','FontSize',14)

figure(2)
plot(alpha,cdswp1,'-*','LineWidth',1.5)
hold on
plot(alpha,cdswp2,':x','LineWidth',1.5)
hold off
xlabel('\alpha','FontSize',14)
ylabel('C_D','FontSize',14)
legend({str1,str2},'Location','best','FontSize',14)
title('C_D vs \alpha','FontSize',14)

figure(3)
plot(clswp1,cdswp1,'-*','LineWidth',1.5)
hold on
plot(clswp1,cdswp2,':x','LineWidth',1.5)
hold off
xlabel('C_L','FontSize',14)
ylabel('C_D','FontSize',14)
legend({str1,str2},'Location','best','FontSize',14)
title('C_L vs C_D','FontSize',14)

figure(3)
plot(xs,-cp1)
hold on
plot(xs,-cp2)


figure(4)
plot(alpha,lovdswp1,'-*','LineWidth',1.5)
hold on
plot(alpha,lovdswp2,':x','LineWidth',1.5)
hold off
xlabel('\alpha','FontSize',14)
ylabel('C_L/C_D','FontSize',14)
title('C_L/C_D vs alpha','FontSize',14)


%%%%%streamline plot%%%%%%%
% Define grid variables, where nx and ny is the no. of point in x and y
% nx = 51;
% ny = 41;
% xmin = -1.5;
% xmax = 1.5;
% ymin = -1.5;
% ymax = 1.5;
% 
% %Preallocating matrices
% xm=zeros(nx,ny);
% ym=zeros(nx,ny);
% psi=zeros(nx,ny);
% psi_k=zeros(nx,ny);
% infa=zeros(nx,ny);
% infb=zeros(nx,ny);
% 
% 
% % generate matrices xm, ym
% for i=1:1:nx
%     for j=1:1:ny
%         xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
%         ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
%         psi(i,j) = ym(i,j);
%     end
% end
% 
% %calculate streamfunction
% for k=1:1:np
%     for i=1:1:nx
%         for j=1:1:ny
%            [infa(i,j),infb(i,j)] = panelinf(xs(k),ys(k),xs(k+1),ys(k+1),xm(i,j),ym(i,j));
%            psi_k(i,j) =  gam1(k)*infa(i,j) + gam1(k+1)*infb(i,j);
%         end
%     end
%     psi = psi + psi_k;
% end
% 
% figure(5)
% c = -1.75:0.1:1.75;
% contour(xm,ym,psi,c);
% hold on
% wing=plot(xs,ys);
% rotate(wing, [0 0 1], -alpha(end))
% hold off 
% title('Plot of streamline');
% xlabel('x');
% ylabel('y');
%%%%%streamline plot%%%%%%%



