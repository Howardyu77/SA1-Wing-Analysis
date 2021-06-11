close all
clf

name=section;
xs1=xs;
ys1=ys;
clswp1=clswp;
cp1=cp;
lovdswp1=lovdswp;

%  Read in the parameter file
caseref = 'low';
parfile = ['Parfiles/' caseref '.txt'];
fprintf(1, '%s\n\n', ['Reading in parameter file: ' parfile])
[section np Re alpha] = par_read(parfile);


[xs, ys, alpha,cp, clswp, cdswp, lovdswp,gam,flow_chic] = foil_function(caseref);
figure(1)
plot(xs,cp,'LineWidth',1.5)
xlabel('x/c','FontSize',14)
ylabel('c_p','FontSize',14)
axis ij


figure(2)
plot(xs,ys,'LineWidth',1.5)
hold on
xstag = xs(ipstag)*(1-fracstag) + xs(ipstag+1)*fracstag;
ystag = ys(ipstag)*(1-fracstag) + ys(ipstag+1)*fracstag;
plot(xstag,ystag,'x','MarkerSize',12,'LineWidth',2,'color','#D95319',...
    'DisplayName','Stagnation point');
hold on
if iunt~=0
    is = ipstag + 1 - iunt;
    plot(xs(is),ys(is),'.','MarkerSize',20,'LineWidth',2,'color','#4DBEEE',...
        'DisplayName',"Natural transition");
end
if ilnt~=0
    is = ipstag + ilnt;
    plot(xs(is),ys(is),'.','MarkerSize',20,'LineWidth',2,'color','#4DBEEE',...
        'DisplayName',"Natural transition");
end
if iuls~=0
    is = ipstag + 1 - iuls;
    plot(xs(is),ys(is),'*','MarkerSize',8,'LineWidth',2,'color','#7E2F8E',...
        'DisplayName',"Laminar separation");
    if iutr~=0
        is = ipstag + 1 - iutr;
        plot(xs(is),ys(is),'d','MarkerSize',10,'LineWidth',2,'color','#77AC30',...
        'DisplayName',"Turbulent reattachment");
    end
end
if ills~=0
    is = ipstag + ills;
    plot(xs(is),ys(is),'*','MarkerSize',8,'LineWidth',2,'color','#7E2F8E',...
        'DisplayName',"Laminar separation");
    if iltr~=0
        is = ipstag + iltr;
        plot(xs(is),ys(is),'d','MarkerSize',10,'LineWidth',2,'color','#77AC30',...
        'DisplayName',"Turbulent reattachment");
    end
end
if iuts~=0
    is = ipstag + 1 - iuts;
    plot(xs(is),ys(is),'+','MarkerSize',10,'LineWidth',2.5,'color','#4DBEEE',...
        'DisplayName',"Turbulent separation");
end
if ilts~=0
    is = ipstag + ilts;
    plot(xs(is),ys(is),'+','MarkerSize',10,'LineWidth',2.5,'color','#4DBEEE',...
        'DisplayName',"Turbulent separation");
end
xlabel('x/c','FontSize',14)
ylabel('y/c','FontSize',14)
legendUnq();
axis equal
axis([0 1 -.2 .2])
legend('FontSize',14,'Location','Best')