function [T, Y]=FOLiu(parameters, orders, TSim, Y0)
%
% Numerical Solution of the Fractional-Order Liu's System
%
%   D^q1 x(t) = -ax(t) - e y(t)^2
%   D^q2 y(t) = b y(t) - k x(t) z(t)
%   D^q3 z(t) = - c z(t) + m x(t) y(t)
%
% function [T, Y] = FOLiu(parameters, orders, TSim, Y0)
%
% Input:    parameters - model parameters [a, b, c, e, k, m]
%           orders - derivatives orders [q1, q2, q3]
%           TSim - simulation time (0 - TSim) in sec
%           Y0 - initial conditions [Y0(1), Y0(2), Y0(3)]
%
% Output:   T - simulation time (0 : Tstep : TSim)
%           Y - solution of the system (x=Y(1), y=Y(2), z=Y(3))
%
% Author:  (c) Ivo Petras (ivo.petras@tuke.sk), 2010.
%

% time step:
h=0.005; 
% number of calculated mesh points:
n=round(TSim/h);
%orders of derivatives, respectively:
q1=orders(1); q2=orders(2); q3=orders(3);
% constants of Liu's system:
a=parameters(1); b=parameters(2); c=parameters(3);
e=parameters(4); k=parameters(5); m=parameters(6);
% binomial coefficients calculation:
cp1=1; cp2=1; cp3=1;
for j=1:n
    c1(j)=(1-(1+q1)/j)*cp1;
    c2(j)=(1-(1+q2)/j)*cp2;
    c3(j)=(1-(1+q3)/j)*cp3;
    cp1=c1(j); cp2=c2(j); cp3=c3(j);
end
% initial conditions setting:
x(1)=Y0(1); y(1)=Y0(2); z(1)=Y0(3);
% calculation of phase portraits /numerical solution/:
for i=2:n
    x(i)=(-a*x(i-1)+e*(y(i-1)^2))*h^q1 - memo(x, c1, i);
    y(i)=(b*y(i-1)-k*x(i)*z(i-1))*h^q2 - memo(y, c2, i);
    z(i)=(-c*z(i-1)+m*x(i)*y(i))*h^q3 - memo(z, c3, i);
end
for j=1:n
    Y(j,1)=x(j);
    Y(j,2)=y(j);
    Y(j,3)=z(j);
end
T=h:h:TSim;
%