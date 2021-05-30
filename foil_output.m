%    foil.m
%
%  Script to analyse an aerofoil section using potential flow calculation
%  and boundary layer solver.
%

clear all



%  Read in the parameter file
caseref = 'tryout'
parfile = ['Parfiles/' caseref '.txt'];
fprintf(1, '%s\n\n', ['Reading in parameter file: ' parfile])
[section np Re alpha] = par_read(parfile);

[xs, ys, alpha, clswp1, cdswp1, lovdswp1] = foil_function('tryout');

[xs, ys, alpha, clswp2, cdswp2, lovdswp2] = foil_function('tryout1');

str='Re=' + string(sprintf('%1.2e',Re));

%%Post processing
figure(1)
plot(alpha,clswp1,'-*')
hold on
plot(alpha,clswp2,':x')
hold off
xlabel('\alpha','FontSize',14)
ylabel('C_L','FontSize',14)
title('C_L vs \alpha at '+str,'FontSize',14)

figure(2)
plot(alpha,cdswp1,'-*')
hold on
plot(alpha,cdswp2,':x')
hold off
xlabel('\alpha','FontSize',14)
ylabel('C_D','FontSize',14)
title('C_D vs \alpha at '+str,'FontSize',14)

figure(3)
plot(clswp1,cdswp1,'-*')
hold on
plot(clswp1,cdswp2,':x')
hold off
xlabel('C_L','FontSize',14)
ylabel('C_D','FontSize',14)
title('C_L vs C_D at '+str,'FontSize',14)