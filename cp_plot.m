
[xs, ys, alpha1,cp1, clswp1, cdswp1, lovdswp1,gam1] = foil_function('naca0012@3e6');
plot(xs,cp1);
hold on
plot(x_free_6e6_10,cp_free_6e6_10,'-*')
hold off
xlabel('x','Fontsize',14);
ylabel('c_p','Fontsize',14);
legend({'Numerical solution','Abbott, I. H. and von Doenhoff'},'Fontsize',10,'Location','best');