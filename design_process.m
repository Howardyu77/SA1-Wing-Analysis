%    foil.m
%
%  Script to analyse an aerofoil section using potential flow calculation
%  and boundary layer solver.
%
close all
clf

name=section;
xs1=xs;
ys1=ys;
clswp1=clswp;
cp1=cp;
lovdswp1=lovdswp;

%  Read in the parameter file
caseref = 'high';
parfile = ['Parfiles/' caseref '.txt'];
fprintf(1, '%s\n\n', ['Reading in parameter file: ' parfile])
[section np Re alpha] = par_read(parfile);


[xs, ys, alpha,cp, clswp, cdswp, lovdswp,gam,flow_chic] = foil_function(caseref);
figure(1)
plot(xs,cp1,'LineWidth',1.5)
hold on
plot(xs,cp,'LineWidth',1.5)
xlabel('x/c','FontSize',14)
ylabel('c_p','FontSize',14)
axis ij
legend({name, section},'FontSize',14,'Location','Best')

figure(2)
plot(xs1,ys1,'LineWidth',1.5)
hold on
plot(xs,ys,'LineWidth',1.5)
xlabel('x/c','FontSize',14)
ylabel('y/c','FontSize',14)
axis equal
axis([0 1 -.2 .2])
legend({name, section},'FontSize',14,'Location','Best')
if length(alpha)~=1
    figure(3)
    plot(alpha,clswp1,'LineWidth',1.5)
    hold on
    plot(alpha,clswp,'LineWidth',1.5)
    xlabel('\alpha','FontSize',14)
    ylabel('c_l','FontSize',14)
    legend({name, section},'FontSize',14,'Location','Best');
    figure(4)
    plot(alpha,lovdswp1,'LineWidth',1.5)
    hold on
    plot(alpha,lovdswp,'LineWidth',1.5)
    xlabel('\alpha','FontSize',14)
    ylabel('c_l/c_d','FontSize',14)
    legend({name, section},'FontSize',14,'Location','Best')   
end
% str1='Re=' + string(sprintf('%1.2e',Re1));
% str2='Re=' + string(sprintf('%1.2e',Re2));
% %%Post processing
% figure(1)
% plot(alpha,clswp1,'-*','LineWidth',1.5)
% hold on
% plot(alpha,clswp2,':x','LineWidth',1.5)
% hold off
% xlabel('\alpha','FontSize',14)
% ylabel('C_L','FontSize',14)
% legend({str1,str2},'Location','best','FontSize',14)
% title('C_L vs \alpha','FontSize',14)
% 
% figure(2)
% plot(alpha,cdswp1,'-*','LineWidth',1.5)
% hold on
% plot(alpha,cdswp2,':x','LineWidth',1.5)
% hold off
% xlabel('\alpha','FontSize',14)
% ylabel('C_D','FontSize',14)
% legend({str1,str2},'Location','best','FontSize',14)
% title('C_D vs \alpha','FontSize',14)
% 
% figure(3)
% plot(clswp1,cdswp1,'-*','LineWidth',1.5)
% hold on
% plot(clswp1,cdswp2,':x','LineWidth',1.5)
% hold off
% xlabel('C_L','FontSize',14)
% ylabel('C_D','FontSize',14)
% legend({str1,str2},'Location','best','FontSize',14)
% title('C_L vs C_D','FontSize',14)





% figure(4)
% plot(alpha,lovdswp1,'-*','LineWidth',1.5)
% hold on
% plot(alpha,lovdswp2,':x','LineWidth',1.5)
% hold off
% xlabel('\alpha','FontSize',14)
% ylabel('C_L/C_D','FontSize',14)
% title('C_L/C_D vs alpha','FontSize',14)