function [infa, infb] = panelinf(xs,ys,x,y)
%   generates vectors of fa and fb
%   x,y are grid points, xs,ys are panel corners
X=zeros(length(xs));
Y=zeros(length(xs));
del=zeros(length(xs));

for i=1:length(xs)
    if i==length(xs)
        d =[xs(1)-xs(i), ys(1)-ys(i)];
    else   
    d =[xs(i+1)-xs(i), ys(i+1)-ys(i)];  
    r = [x(i)-xs(i), y(i)-ys(i)];
    del(i)= norm(d);
    t = d/del(i);
    n = [-t(2),t(1)];
    X(i) = dot(r,t);
    Y(i) = dot(r,n);
    end
end
[infa, infb] = refpaninf(del,X,Y);
end


