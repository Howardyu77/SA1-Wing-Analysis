close
subplot(2,1,1)
plot(xs(ipstag+1:end),-cpl)
hold on
plot(flip(xs(1:ipstag)),-cpu)
hold off
legendUnq();
subplot(2,1,2)
xstag = xs(ipstag)*(1-fracstag) + xs(ipstag+1)*fracstag;
ystag = ys(ipstag)*(1-fracstag) + ys(ipstag+1)*fracstag;
plot(xstag,ystag,'x','MarkerSize',12,'LineWidth',2,'color','#D95319',...
    'DisplayName','Stagnation point');
hold on
if iunt~=0
    is = ipstag + 1 - iunt;
    plot(xs(is),ys(is),'x','MarkerSize',12,'LineWidth',2,'color','#EDB120',...
        'DisplayName',"Natural transition");
end
if ilnt~=0
    is = ipstag + ilnt;
    plot(xs(is),ys(is),'x','MarkerSize',12,'LineWidth',2,'color','#EDB120',...
        'DisplayName',"Natural transition");
end
if iuls~=0
    is = ipstag + 1 - iuls;
    plot(xs(is),ys(is),'x','MarkerSize',12,'LineWidth',2,'color','#4DBEEE',...
        'DisplayName',"Laminar separation");
    if iutr~=0
        is = ipstag + 1 - iutr;
        plot(xs(is),ys(is),'x','MarkerSize',12,'LineWidth',2,'color','#7E2F8E',...
        'DisplayName',"Turbulent reattachment");
    end
end
if ills~=0
    is = ipstag + ills;
    plot(xs(is),ys(is),'x','MarkerSize',12,'LineWidth',2,'color','#4DBEEE',...
        'DisplayName',"Laminar separation");
    if iltr~=0
        is = ipstag + iltr;
        plot(xs(is),ys(is),'x','MarkerSize',12,'LineWidth',2,'color','#7E2F8E',...
        'DisplayName',"Turbulent reattachment");
    end
end
if iuts~=0
    is = ipstag + 1 - iuts;
    plot(xs(is),ys(is),'x','MarkerSize',12,'LineWidth',2,'color','#77AC30',...
        'DisplayName',"Turbulent separation");
end
if ilts~=0
    is = ipstag + ilts;
    plot(xs(is),ys(is),'x','MarkerSize',12,'LineWidth',2,'color','#77AC30',...
        'DisplayName',"Turbulent separation");
end
plot(xs,ys,'color','#0072BD')
axis equal
xlim = ([0 1]);
legendUnq();
ax = gca
diff = ax.YLim(2) - ax.YLim(1);
ax.YLim = [max(ys)+0.05-diff,max(ys)+0.05]
legend('location','best','FontSize',8)
xlabel('$x/c$','Interpreter','latex','FontSize',12)
ylabel('$y/c$','Interpreter','latex','FontSize',12)
subplot(2,1,1)
xlim = ([0 1]);
ylabel('$-c_p$','Interpreter','latex','FontSize',12)
