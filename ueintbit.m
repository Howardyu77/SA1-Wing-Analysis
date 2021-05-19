function f = ueintbit(xa,ua,xb,ub)
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here
u_bar=(ua+ub)/2;
del_u=ub-ua;
del_x=xb-xa;
f=del_x*(u_bar^5+(5/6)*u_bar^3*del_u^2+u_bar*del_u^4/16);
end

