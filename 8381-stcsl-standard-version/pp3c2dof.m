function [param]=pp3c2dof(input)
% [param]=pp3c2dof(input)
% Pole placement controller for 2nd order processes.
% This function computes parameters of the controller.
% The dynamic behaviour of the closed-loop is similar to 
% second order continuous system with characteristic polynomial 
% s^2 + 2*xi*omega*s + omega^2.
% Output of the controller is calculated follows:
%
%                              r0            
% U(z^-1) = ------------------------------------ * W(z^-1) - 
%           (1 - z^-1) * (1 + p1*z^-1 + p2*z^-1) 
%
%
%             q0 + q1*z^-1 + q2*z^-2 + q3*z^-2  
%           ------------------------------------ * Y(z^-1)
%           (1 - z^-1) * (1 + p1*z^-1 + p2*z^-1)
%
% Transfer function of the controlled system is:
%
%               b1*z^-1 + b2*z^-2 + b3*z^-3
% Gs(z^-1) = ---------------------------------
%             1 + a1*z^-1 + a2*z^-2 + a3*z^-3
%
% Input: 
%   input(1:6) ... [a1 b1 a2 b2 a3 b3]
%   input(7) ... sample time T0
%   input(8) ... damping factor xi
%   input(9) ... natural frequency omega
% Output: param ... controller parameters  [r0; q0; q1; q2; p0; p1];

a1 = input(1);
b1 = input(2);
a2 = input(3);
b2 = input(4);
a3 = input(5);
b3 = input(6);
T0 = input(7);
xi = input(8);
om = input(9);

d2=exp(-2*xi*om*T0);
if (xi <= 1)
   d1=-2*exp(-xi*om*T0)*cos(om*T0*(sqrt(1-xi*xi)));
else
   d1=-2*exp(-xi*om*T0)*cosh(om*T0*(sqrt(xi*xi-1)));
end

% FBFW controller: Y=BR/(APK+BQ)*W
% conditions: 1) APK+BQ=D
%             2) BR+FS=D  where W=H/F and S is any polynomial
% 1st condition:
%  A = 1 + a1*z^-1 + a2*z^-2 + a3*z^-3   B =      b1*z^-1 + b2*z^-2 +  b3*z^-3
%  P = 1 + p1*z^-1 + p2*z^-2             Q = q0 + q1*z^-1 + q2*z^-2 +  q3*z^-3
%  K = 1 - z^-1
% system of linear equations:
% [b1  0   0   0  1       0 ]   [q0]   [ d1+1-a1]
% [b2  b1  0   0 a1-1     1 ]   [q1]   [d2+a1-a2]
% [b3  b2 b1   0 a2-a1  a1-1] * [q2] = [ a2-a3  ]
% [ 0  b3 b2  b1 a3-a2 a2-a1]   [q3]   [  a3    ]
% [ 0   0 b3  b2  -a3  a3-a2]   [p1]   [   0    ]
% [ 0   0  0  b3   0     -a3]   [p2]   [   0    ]

q0 = -(b1*b2^2*a3^2-b1^2*a2^2*b3+b2*b3^2*a1-b2^2*b3*a2-2*a1*b1*a2*b3^2+b1*a3^2*b3*b2-b3^3+b3^3*a1+a2^2*b3^2*b2+ ...
    b1*b3*a3*b2*a2-3*b1*b2*b3*a3+2*b1^2*b3*a3*a1-b2^2*a2*a3*b3+a1*b3^2*a3*b2+b1^2*b2*a2*a3-b1*b2^2*a1*a3+ ...
    3*a1*b1*b2*b3*a3+2*a1*b1*b3^2*a3-b3^2*b2*a1^2-b2^3*a1*a3-2*a1*b3^3*a2+b3*a2*b2^2*a1-b3^2*a1*b2*a2+b3^3*a2- ...
    b3^3*a1^2-b1^2*b3*a3^2-b1*b3^2*a2^2+b2^3*a3-b1^3*a3^2-b1*b3^2*a1^2+b1*b3*b2*a2*a1-2*a1^2*b1*b2*b3*a3- ...
    a2*a3*b2^3+b2^2*a2^2*b3+b3^3*a3+2*b1*a2*b3^2-2*b1^2*b3*a3*a1^2+b1*b2^2*a1^2*a3-2*a1^2*b1*b3^2*a3+ ...
    b3*a3*b2^2*a1^2-b3*a2*b2^2*a1^2-b3^2*a1^2*b2*a2-b1^2*a2^2*b3*d1+b1^2*a2^2*b3*a1+b2*b3^2*a1*d1-b2^2*b3*a2*d1- ...
    b3^2*a3*b2*d1-b3^2*b2*a1^2*d1-b2^3*a1*a3*d1-b1*b3*b2*a2*a1^2+b1*b3*a3*b2*a2*d1-b1*b3*a3*b2*a2*a1- ...
    3*b1*b2*b3*a3*d1+2*b1^2*b3*a3*a1*d1+b1*b2^2*a2*a3*d1-b1*b2^2*a2*a3*a1-b1*b3*a2^2*b2*d1+b1*b3*a2^2*b2*a1+ ...
    b1^2*b2*a2*a3*d1-b1^2*b2*a2*a3*a1-b1*b2^2*a1*a3*d1+2*a1*b1*b2*b3*a3*d1+2*a1*b1*b3^2*a3*d1-b3*a3*b2^2*a1*d1+ ...
    b3*a2*b2^2*a1*d1+b3^2*a1*b2*a2*d1-b1^2*b3*a3^2*d1+b1^2*b3*a3^2*a1-b1*b3^2*a2^2*d1+b1*b3^2*a2^2*a1- ...
    b1*b3^2*a1^2*d1-b1*b3^2*a3*d1+2*b1*a2*b3^2*d1-b1^2*b2*a3^2*d1+b1^2*b2*a3^2*a1+b2*b3^2*a1*d2-b1*b3^2*a3*d2+ ...
    b3*a3*b2^2*d2-b2^2*b3*a2*d2-b3^2*b2*a2*d2+b3^2*b2*a1^3+b2^3*a1^2*a3+b1*b3^2*a1^3+b3^3*a1*d1+b3^3*a2*d1- ...
    b3^3*a1^2*d1+b2^3*a3*d1-b1^3*a3^2*d1+b1^3*a3^2*a1+b3^3*a1*d2+b2^3*a3*d2-b3^3*d1+b3^3*a1^3+b1*b3*b2*a2*a1*d1- ...
    b3^3*d2-2*b1*b2*b3*a3*d2+b1*a2*b3^2*d2)/(b2+b3+b1)/(b1^3*a3^2-b1^2*b2*a2*a3-2*b1^2*b3*a3*a1+b1^2*a2^2*b3+ ...
    b1*b3^2*a1^2-2*b1*a2*b3^2+3*b1*b2*b3*a3-b1*b3*b2*a2*a1+b1*b2^2*a1*a3-b2^3*a3+b3^3-b2*b3^2*a1+b2^2*b3*a2);

q1 = (b1*b2^2*a3^2+a1*b3^3*a3-2*a1*b1*a2*b3^2-b1*a3^2*b3*b2+b3^3*a1+a1*b3^3*a2*d1-b1*b2^2*a3^2*d1+a2*a3*b2^3*d1- ...
    a2*a3*b2^3*a1-b2^2*a2^2*b3*d1+b2^2*a2^2*b3*a1-a2^2*b3^2*b2*d1+a2^2*b3^2*b2*a1+a2^2*b3^2*b2+a3^2*b3*b2^2- ...
    2*b1*b3*a3*b2*a2-2*b2*a2*a3*b3^2-2*b2^2*a2*a3*b3-b1*a3^2*b3^2+b2^3*a3^2+2*a1*b3^2*a3*b2+3*a1*b1*b2*b3*a3+ ...
    2*a1*b1*b3^2*a3-b3^2*b2*a1^2-b2^3*a1*a3-a1*b3^3*a2+b3*a2*b2^2*a1-b3^3*a1^2-b1^2*b3*a3^2+b1*b3^2*a2^2- ...
    2*a1^2*b1*b2*b3*a3-b1*b2^2*a2*a3*d2+b1*b3*a2^2*b2*d2-b1*b3*a3*b2*a2*d2-a1^2*b3^3*a2-b3^3*a3*d1-b1^2*a2^3*b3- ...
    b1*b3^2*a2^3+b1^3*a3^2*d2-b1^3*a3^2*a2-b3^3*a2*d2-2*b1^2*b3*a3*a1^2+b1*b2^2*a1^2*a3-2*a1^2*b1*b3^2*a3+ ...
    b3*a3*b2^2*a1^2-b3*a2*b2^2*a1^2-2*b3^2*a1^2*b2*a2+b1^2*a2^2*b3*a1-b3^2*a3*b2*d1-b3^2*b2*a1^2*d1-b2^3*a1*a3*d1- ...
    b1*b3*b2*a2*a1^2+b1*b3*a3*b2*a2*a1+b1*b2^2*a2*a3*d1-2*b1*b2^2*a2*a3*a1-b1*b3*a2^2*b2*d1+2*b1*b3*a2^2*b2*a1- ...
    b1^2*b2*a2*a3*a1+2*a1*b1*b2*b3*a3*d1+a1*b1*b3^2*a3*d1-b3*a3*b2^2*a1*d1+b3*a2*b2^2*a1*d1+2*b3^2*a1*b2*a2*d1+ ...
    b1^2*b3*a3^2*a1+b1*b3^2*a2^2*a1-b1*b3^2*a3*d1-b1^2*b2*a3^2*d1+b1^2*b2*a3^2*a1+b3*a3*b2^2*d2-b3^2*b2*a2*d2+ ...
    b3^2*b2*a1^3+b2^3*a1^2*a3+b1*b3^2*a1^3+b3^3*a1*d1-b3^3*a1^2*d1+b1^3*a3^2*a1+b3^3*a1*d2-b1*a3^2*b3*b2*d1+ ...
    b2^2*a2*a3*b3*d1-b2^2*a2*a3*b3*a1+b1^2*b2*a2^2*a3+b1*b2^2*a2^2*a3-b1*b3*a2^3*b2+b1*b3^2*a1^2*d2- ...
    b1*b3^2*a1^2*a2+b1^2*b2*a3^2*d2+b3^3*a1^3+b1*b2*b3*a3*d2-b1*a2*b3^2*d2+b3^3*a2^2+b1*b3*a3*b2*a2^2- ...
    2*b1^2*b3*a3*a1*d2+2*b1^2*b3*a3*a1*a2+b1*b2^2*a1*a3*d2-b1*b3*b2*a2*a1*d2-a1*b1*a2*b3^2*d2-a1*b1*b3^2*a3*d2+ ...
    2*a1*b1*b3^2*a3*a2-b1^2*b2*a3^2*a2+b1^2*a2^2*b3*d2+b1^2*b3*a3^2*d2-b1^2*b3*a3^2*a2+b1*b3^2*a2^2*d2+ ...
    b3^2*a3*b2*d2-b1^2*b2*a2*a3*d2)/(b2+b3+b1)/(b1^3*a3^2-b1^2*b2*a2*a3-2*b1^2*b3*a3*a1+b1^2*a2^2*b3+b1*b3^2*a1^2- ...
    2*b1*a2*b3^2+3*b1*b2*b3*a3-b1*b3*b2*a2*a1+b1*b2^2*a1*a3-b2^3*a3+b3^3-b2*b3^2*a1+b2^2*b3*a2);

q2 = (b3^3*a3*a2-b3^3*a3*d2-b2^3*a3^2*a1-a1^2*b3^3*a3-b3^2*a3^2*b2-b1^2*b3*a3^3-b1^2*b2*a3^3+a1*b3^3*a3*d1- ...
    a1^2*b3^2*a3*b2+2*b1*a3^2*b3^2*a1-b1*a3^2*b3^2*d1-b1*b2^2*a3^2*a1-a3^2*b3*b2^2*a1+a3^2*b3*b2^2*d1- ...
    b1*a2^2*a3*b3^2-b1*b2^2*a3^2*d2+b1*b2^2*a3^2*a2-b1*a3^2*b3*b2-b1^3*a3^3-a1*b3^3*a2*d1+b1*b2^2*a3^2*d1- ...
    a2*a3*b2^3*d1+a2*a3*b2^3*a1+b2^2*a2^2*b3*d1-b2^2*a2^2*b3*a1+a2^2*b3^2*b2*d1-a2^2*b3^2*b2*a1-a3^2*b3*b2^2+ ...
    3*b1*b3*a3*b2*a2+2*b2*a2*a3*b3^2-b1^2*a2^2*b3*a3+2*b1*a2*a3*b3^2-a1*b3^3*a2-b3^2*a1*b2*a2+b3^3*a2- ...
    2*b1*b3^2*a2^2-a2*a3*b2^3+b2^2*a2^2*b3+b1*b2^2*a2*a3*d2-b1*b3*a2^2*b2*d2+2*b1*b3*a3*b2*a2*d2+b1*a2*a3*b3^2*d1+ ...
    b2^3*a3^2*d1+a1*b3^2*a3*b2*d1+2*b1*a3^2*b3*b2*a1+a1^2*b3^3*a2+b1^2*a2^3*b3+b1*b3^2*a2^3+b1^3*a3^2*a2+ ...
    b3^3*a2*d2-b2*a2*a3*b3^2*d1+b2*a2*a3*b3^2*a1-a1^2*b1*b3^2*a3+b3^2*a1^2*b2*a2+b1*b3*a3*b2*a2*d1- ...
    b1*b3*a3*b2*a2*a1+b1*b2^2*a2*a3*a1-b1*b3*a2^2*b2*a1+a1*b1*b3^2*a3*d1-b3^2*a1*b2*a2*d1-b1^2*b3*a3^2*d1+ ...
    2*b1^2*b3*a3^2*a1-b1*b3^2*a2^2*d1-b1*b3^2*a3*d2+b3^3*a2*d1-b1*a3^2*b3*b2*d1-2*b2^2*a2*a3*b3*d1+ ...
    2*b2^2*a2*a3*b3*a1-b1^2*b2*a2^2*a3-b1*b2^2*a2^2*a3+b1*b3*a2^3*b2+b1*b3^2*a1^2*a2-b1^2*b2*a3^2*d2- ...
    b1*a3^2*b3*b2*d2-b3^3*a2^2-2*b1*b3*a3*b2*a2^2-2*b1^2*b3*a3*a1*a2+a1*b1*a2*b3^2*d2-2*a1*b1*b3^2*a3*a2+ ...
    2*b1^2*b2*a3^2*a2+b1^2*b3*a3^2*a2-b1*b3^2*a2^2*d2+b1*a3^2*b3*b2*a2+b1*a2*a3*b3^2*d2-b3^2*a3*b2*d2)/(b2+b3+ ...
    b1)/(b1^3*a3^2-b1^2*b2*a2*a3-2*b1^2*b3*a3*a1+b1^2*a2^2*b3+b1*b3^2*a1^2-2*b1*a2*b3^2+3*b1*b2*b3*a3- ...
    b1*b3*b2*a2*a1+b1*b2^2*a1*a3-b2^3*a3+b3^3-b2*b3^2*a1+b2^2*b3*a2);

q3 = a3*(b1^2*a2^2*b3-b1*b3*b2*a2*d2+b3^2*b2*a2*d1-b2*b3^2*a1+b2^2*b3*a2+b3^3-b3^3*a1-b1*b3*a3*b2*a2+3*b1*b2*b3*a3- ...
    2*b1^2*b3*a3*a1-b1*b2^2*a2*a3+b1*b3*a2^2*b2-b1^2*b2*a2*a3+b1*b2^2*a1*a3-2*a1*b1*b2*b3*a3-2*a1*b1*b3^2*a3+ ...
    b3^2*a3*b2+b3^2*b2*a1^2+b2^3*a1*a3+b3*a3*b2^2*a1-b3*a2*b2^2*a1-b3^2*a1*b2*a2+b1*b2^2*a3*d2-b3^3*a2+b3^3*a1^2+ ...
    b1^2*b3*a3^2+b1*b3^2*a2^2-b2^3*a3+b1^3*a3^2+b1*b3^2*a1^2+b1*b3^2*a3-b1*b3*b2*a2*a1-2*b1*a2*b3^2+b1^2*b2*a3^2+ ...
    b1*b3^2*a1*d2-b1^2*b3*a3*d2-b2*b3^2*a1*d1+b2^2*b3*a2*d1+2*b1*b2*b3*a3*d1+b1*b3^2*a3*d1-b1*a2*b3^2*d1- ...
    b2^2*a3*b3*d1-b3^3*a1*d1-b2^3*a3*d1+b3^3*d1+b3^3*d2+b1*b2*b3*a3*d2-b1*a2*b3^2*d2)/(b2+b3+b1)/(b1^3*a3^2- ...
    b1^2*b2*a2*a3-2*b1^2*b3*a3*a1+b1^2*a2^2*b3+b1*b3^2*a1^2-2*b1*a2*b3^2+3*b1*b2*b3*a3-b1*b3*b2*a2*a1+ ...
    b1*b2^2*a1*a3-b2^3*a3+b3^3-b2*b3^2*a1+b2^2*b3*a2);

p1 = (-b1*b3^3*a2+b1^3*b2*a3^2-b1^2*b3^2*a3*d2+b1^2*a2*b3^2*d2+b1*a2^2*b3^2*b2-b1*a2*a3*b2^3+b1*b2^2*a2^2*b3- ...
    2*b1^2*b2*b3*a3*d2-b1*b2^2*a2*a3*b3+b1*b2*b3^2*a1*d2+b1*b3*a3*b2^2*d2-b1*b2^2*b3*a2*d2-b1*b3^2*b2*a2*d2+ ...
    b1*b3^3*a1*d2+b1*b2^3*a3*d2-b3*a3*b2^3+b3*a2*b2^3-b3^2*b2^2*a1-2*b3^3*a1*b2+b3^2*b2^2*a2+b3^4-b2^4*a3+ ...
    b3^3*b2+b3^4*d1-b3^4*a1+b1^2*b3*a2^2*b2-b1^2*b2^2*a2*a3+3*b1*b3^2*a3*b2-2*b1*b3^2*b2*a2+b1*b3^2*b2*a1^2+ ...
    b1*b2^3*a1*a3+3*b1*b3*a3*b2^2-2*b1^2*b3*a3*b2*a1-2*b1*b3*a3*b2^2*a1-b1*b3*a2*b2^2*a1+b3^2*b2^2*a1^2+ ...
    b3^3*a1^2*b2-b2^4*a3*d1+b2^4*a3*a1+b3^3*b2*d1+b1*b3^3*a3+b1^2*a3^2*b3*b2+b1*b3^3*a1*d1-b3^2*b2^2*a1*d1- ...
    b3^3*a1*b2*d1-b3^2*a3*b1^2*d1-b1*b3^3*a2*d1-b3*a3*b2^3*d1+b3*a3*b2^3*a1+b3*a2*b2^3*d1-b3*a2*b2^3*a1+ ...
    3*b1*b3*a3*b2^2*d1+2*b1*b3^2*a3*b2*d1-2*b1*b3^2*a3*b2*a1-2*b1*b3^2*b2*a2*d1+b3^2*b2^2*a2*d1-b3^2*b2^2*a2*a1- ...
    b1*b3^3*d2+b1^2*b2^2*a3^2)/(b2+b3+b1)/(b1^3*a3^2-b1^2*b2*a2*a3-2*b1^2*b3*a3*a1+b1^2*a2^2*b3+b1*b3^2*a1^2- ...
    2*b1*a2*b3^2+3*b1*b2*b3*a3-b1*b3*b2*a2*a1+b1*b2^2*a1*a3-b2^3*a3+b3^3-b2*b3^2*a1+b2^2*b3*a2);

p2 = b3*(b1^2*a2^2*b3-b1*b3*b2*a2*d2+b3^2*b2*a2*d1-b2*b3^2*a1+b2^2*b3*a2+b3^3-b3^3*a1-b1*b3*a3*b2*a2+3*b1*b2*b3*a3- ...
    2*b1^2*b3*a3*a1-b1*b2^2*a2*a3+b1*b3*a2^2*b2-b1^2*b2*a2*a3+b1*b2^2*a1*a3-2*a1*b1*b2*b3*a3-2*a1*b1*b3^2*a3+ ...
    b3^2*a3*b2+b3^2*b2*a1^2+b2^3*a1*a3+b3*a3*b2^2*a1-b3*a2*b2^2*a1-b3^2*a1*b2*a2+b1*b2^2*a3*d2-b3^3*a2+b3^3*a1^2+ ...
    b1^2*b3*a3^2+b1*b3^2*a2^2-b2^3*a3+b1^3*a3^2+b1*b3^2*a1^2+b1*b3^2*a3-b1*b3*b2*a2*a1-2*b1*a2*b3^2+b1^2*b2*a3^2+ ...
    b1*b3^2*a1*d2-b1^2*b3*a3*d2-b2*b3^2*a1*d1+b2^2*b3*a2*d1+2*b1*b2*b3*a3*d1+b1*b3^2*a3*d1-b1*a2*b3^2*d1- ...
    b2^2*a3*b3*d1-b3^3*a1*d1-b2^3*a3*d1+b3^3*d1+b3^3*d2+b1*b2*b3*a3*d2-b1*a2*b3^2*d2)/(b2+b3+b1)/(b1^3*a3^2- ...
    b1^2*b2*a2*a3-2*b1^2*b3*a3*a1+b1^2*a2^2*b3+b1*b3^2*a1^2-2*b1*a2*b3^2+3*b1*b2*b3*a3-b1*b3*b2*a2*a1+ ...
    b1*b2^2*a1*a3-b2^3*a3+b3^3-b2*b3^2*a1+b2^2*b3*a2);

% 2nd condition - step signal:  F =  1 - z^-1
r0 = (1+d1+d2)/(b1+b2+b3);

%parameters for scfbfw (no explicit compensator)
param=[r0; q0; q1; q2; q3; 1; p1-1; p2-p1; -p2];
