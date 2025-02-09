% Residue Curve Map for Reactive Systems / Isopropyl Acetate Chemistry
% Author's Data: Housam BINOUS
% Department of Chemical Engineering
% National Institute of Applied Sciences and Technology
% Tunis, TUNISIA
% Email: binoushousam@yahoo.com 


function xdot=RCM_IsopropylAcetate2(t,x,flag)

if isempty(flag),

R=1.987;

P=1.013*1e+5;

T=x(6);

y1=x(5);


gi(1, 1) = 0; 
gi(2, 1) = 81.3926; 
gi(3, 1) = 154.7885; 
gi(4, 1) = 842.6081;
gi(1, 2) = -281.4482; 
gi(2, 2) = 0; 
gi(3, 2) = 140.0972; 
gi(4, 2) = 1655.2550;
gi(1, 3) = 141.0082; 
gi(2, 3) = 269.9609; 
gi(3, 3) = 0; 
gi(4, 3) = 1270.2036;
gi(1, 4) = -219.7238; 
gi(2, 4) = 39.8541; 
gi(3, 4) = 1165.709; 
gi(4, 4) = 0;

a(1, 1) = 0; 
a(2, 1) = 0.3048; 
a(3, 1) = 0.3014; 
a(4, 1) = 0.2997;
a(1, 2) = 0.3048; 
a(2, 2) = 0; 
a(3, 2) = 0.3009; 
a(4, 2) = 0.3255;
a(1, 3) = 0.3014; 
a(2, 3) = 0.3009; 
a(3, 3) = 0; 
a(4, 3) = 0.3300;
a(1, 4) = 0.2997; 
a(2, 4) = 0.3255; 
a(3, 4) = 0.3300; 
a(4, 4) = 0;

for i=1:4
    for j=1:4
        tau(i,j)=gi(i,j)/(R*T);
        G(i, j)= exp(-a(i, j)*tau(i, j));
        end
end

    
GAM(1)=exp((x(1)*G(1, 1)*tau(1, 1) + x(2)*G(2, 1)*tau(2, 1) + x(3)*G(3, 1)*tau(3, 1) +... 
    x(4)*G(4, 1)*tau(4, 1))/(x(1)*G(1, 1) + x(2)*G(2, 1) + x(3)*G(3, 1) + ...
    x(4)*G(4, 1)) + ...
  (x(1)*G(1, 1)*(tau(1, 1) - (x(1)*G(1, 1)*tau(1, 1) + ...
       x(2)*G(2, 1)*tau(2, 1) + x(3)*G(3, 1)*tau(3, 1) + ...
       x(4)*G(4, 1)*tau(4, 1))/(x(1)*G(1, 1) + x(2)*G(2, 1) + x(3)*G(3, 1) + ...
       x(4)*G(4, 1))))/(x(1)*G(1, 1) + x(2)*G(2, 1) + x(3)*G(3, 1) + ...
    x(4)*G(4, 1)) + ...
  (x(2)*G(1, 2)*(tau(1, 2) - (x(1)*G(1, 2)*tau(1, 2) + ...
       x(2)*G(2, 2)*tau(2, 2) + x(3)*G(3, 2)*tau(3, 2) + ...
       x(4)*G(4, 2)*tau(4, 2))/(x(1)*G(1, 2) + x(2)*G(2, 2) + x(3)*G(3, 2) + ... 
       x(4)*G(4, 2))))/(x(1)*G(1, 2) + x(2)*G(2, 2) + x(3)*G(3, 2) + ...
    x(4)*G(4, 2)) + ...
  (x(3)*G(1, 3)*(tau(1, 3) - (x(1)*G(1, 3)*tau(1, 3) + ... 
       x(2)*G(2, 3)*tau(2, 3) + x(3)*G(3, 3)*tau(3, 3) + ...
       x(4)*G(4, 3)*tau(4, 3))/(x(1)*G(1, 3) + x(2)*G(2, 3) + x(3)*G(3, 3) + ... 
       x(4)*G(4, 3))))/(x(1)*G(1, 3) + x(2)*G(2, 3) + x(3)*G(3, 3) + ...
    x(4)*G(4, 3)) + ...
  (x(4)*G(1, 4)*(tau(1, 4) - (x(1)*G(1, 4)*tau(1, 4) + ...
       x(2)*G(2, 4)*tau(2, 4) + x(3)*G(3, 4)*tau(3, 4) + ...
       x(4)*G(4, 4)*tau(4, 4))/(x(1)*G(1, 4) + x(2)*G(2, 4) + x(3)*G(3, 4) + ... 
       x(4)*G(4, 4))))/(x(1)*G(1, 4) + x(2)*G(2, 4) + x(3)*G(3, 4) + x(4)*G(4, 4)));

 GAM(2)=exp((x(1)*G(2, 1)*(tau(2, 1) - (x(1)*G(1, 1)*tau(1, 1) + ... 
       x(2)*G(2, 1)*tau(2, 1) + x(3)*G(3, 1)*tau(3, 1) + ...
       x(4)*G(4, 1)*tau(4, 1))/(x(1)*G(1, 1) + x(2)*G(2, 1) + x(3)*G(3, 1) + ...
       x(4)*G(4, 1))))/(x(1)*G(1, 1) + x(2)*G(2, 1) + x(3)*G(3, 1) + ...
    x(4)*G(4, 1)) + (x(1)*G(1, 2)*tau(1, 2) + x(2)*G(2, 2)*tau(2, 2) + ...
    x(3)*G(3, 2)*tau(3, 2) + x(4)*G(4, 2)*tau(4, 2))/ ...
   (x(1)*G(1, 2) + x(2)*G(2, 2) + x(3)*G(3, 2) + x(4)*G(4, 2)) + ... 
  (x(2)*G(2, 2)*(tau(2, 2) - (x(1)*G(1, 2)*tau(1, 2) + ...
       x(2)*G(2, 2)*tau(2, 2) + x(3)*G(3, 2)*tau(3, 2) + ...
       x(4)*G(4, 2)*tau(4, 2))/(x(1)*G(1, 2) + x(2)*G(2, 2) + x(3)*G(3, 2) + ...
       x(4)*G(4, 2))))/(x(1)*G(1, 2) + x(2)*G(2, 2) + x(3)*G(3, 2) + ...
    x(4)*G(4, 2)) + ...
  (x(3)*G(2, 3)*(tau(2, 3) - (x(1)*G(1, 3)*tau(1, 3) + ...
       x(2)*G(2, 3)*tau(2, 3) + x(3)*G(3, 3)*tau(3, 3) + ...
       x(4)*G(4, 3)*tau(4, 3))/(x(1)*G(1, 3) + x(2)*G(2, 3) + x(3)*G(3, 3) + ...
       x(4)*G(4, 3))))/(x(1)*G(1, 3) + x(2)*G(2, 3) + x(3)*G(3, 3) + ...
    x(4)*G(4, 3)) + ...
  (x(4)*G(2, 4)*(tau(2, 4) - (x(1)*G(1, 4)*tau(1, 4) + ...
       x(2)*G(2, 4)*tau(2, 4) + x(3)*G(3, 4)*tau(3, 4) + ...
       x(4)*G(4, 4)*tau(4, 4))/(x(1)*G(1, 4) + x(2)*G(2, 4) + x(3)*G(3, 4) + ...
       x(4)*G(4, 4))))/(x(1)*G(1, 4) + x(2)*G(2, 4) + x(3)*G(3, 4) + x(4)*G(4, 4)));      
       
GAM(3)=exp((x(1)*G(3, 1)*(tau(3, 1) - (x(1)*G(1, 1)*tau(1, 1) + ...
       x(2)*G(2, 1)*tau(2, 1) + x(3)*G(3, 1)*tau(3, 1) + ...
       x(4)*G(4, 1)*tau(4, 1))/(x(1)*G(1, 1) + x(2)*G(2, 1) + x(3)*G(3, 1) + ...
       x(4)*G(4, 1))))/(x(1)*G(1, 1) + x(2)*G(2, 1) + x(3)*G(3, 1) + ...
    x(4)*G(4, 1)) + ...
  (x(2)*G(3, 2)*(tau(3, 2) - (x(1)*G(1, 2)*tau(1, 2) + ...
       x(2)*G(2, 2)*tau(2, 2) + x(3)*G(3, 2)*tau(3, 2) + ...
       x(4)*G(4, 2)*tau(4, 2))/(x(1)*G(1, 2) + x(2)*G(2, 2) + x(3)*G(3, 2) + ...
       x(4)*G(4, 2))))/(x(1)*G(1, 2) + x(2)*G(2, 2) + x(3)*G(3, 2) + ...
    x(4)*G(4, 2)) + (x(1)*G(1, 3)*tau(1, 3) + x(2)*G(2, 3)*tau(2, 3) + ...
    x(3)*G(3, 3)*tau(3, 3) + x(4)*G(4, 3)*tau(4, 3))/ ...
   (x(1)*G(1, 3) + x(2)*G(2, 3) + x(3)*G(3, 3) + x(4)*G(4, 3)) + ... 
  (x(3)*G(3, 3)*(tau(3, 3) - (x(1)*G(1, 3)*tau(1, 3) + ...
       x(2)*G(2, 3)*tau(2, 3) + x(3)*G(3, 3)*tau(3, 3) + ...
       x(4)*G(4, 3)*tau(4, 3))/(x(1)*G(1, 3) + x(2)*G(2, 3) + x(3)*G(3, 3) + ...
       x(4)*G(4, 3))))/(x(1)*G(1, 3) + x(2)*G(2, 3) + x(3)*G(3, 3) + ...
    x(4)*G(4, 3)) + ...
  (x(4)*G(3, 4)*(tau(3, 4) - (x(1)*G(1, 4)*tau(1, 4) + ...
       x(2)*G(2, 4)*tau(2, 4) + x(3)*G(3, 4)*tau(3, 4) + ...
       x(4)*G(4, 4)*tau(4, 4))/(x(1)*G(1, 4) + x(2)*G(2, 4) + x(3)*G(3, 4) + ...
       x(4)*G(4, 4))))/(x(1)*G(1, 4) + x(2)*G(2, 4) + x(3)*G(3, 4) + x(4)*G(4, 4)));
       
GAM(4)=exp((x(1)*G(4, 1)*(tau(4, 1) - (x(1)*G(1, 1)*tau(1, 1) + ...
       x(2)*G(2, 1)*tau(2, 1) + x(3)*G(3, 1)*tau(3, 1) + ...
       x(4)*G(4, 1)*tau(4, 1))/(x(1)*G(1, 1) + x(2)*G(2, 1) + x(3)*G(3, 1) + ...
       x(4)*G(4, 1))))/(x(1)*G(1, 1) + x(2)*G(2, 1) + x(3)*G(3, 1) + ...
    x(4)*G(4, 1)) + ...
  (x(2)*G(4, 2)*(tau(4, 2) - (x(1)*G(1, 2)*tau(1, 2) + ...
       x(2)*G(2, 2)*tau(2, 2) + x(3)*G(3, 2)*tau(3, 2) + ...
       x(4)*G(4, 2)*tau(4, 2))/(x(1)*G(1, 2) + x(2)*G(2, 2) + x(3)*G(3, 2) + ...
       x(4)*G(4, 2))))/(x(1)*G(1, 2) + x(2)*G(2, 2) + x(3)*G(3, 2) + ...
    x(4)*G(4, 2)) + ...
  (x(3)*G(4, 3)*(tau(4, 3) - (x(1)*G(1, 3)*tau(1, 3) + ...
       x(2)*G(2, 3)*tau(2, 3) + x(3)*G(3, 3)*tau(3, 3) + ...
       x(4)*G(4, 3)*tau(4, 3))/(x(1)*G(1, 3) + x(2)*G(2, 3) + x(3)*G(3, 3) + ...
       x(4)*G(4, 3))))/(x(1)*G(1, 3) + x(2)*G(2, 3) + x(3)*G(3, 3) + ...
    x(4)*G(4, 3)) + (x(1)*G(1, 4)*tau(1, 4) + x(2)*G(2, 4)*tau(2, 4) + ... 
    x(3)*G(3, 4)*tau(3, 4) + x(4)*G(4, 4)*tau(4, 4))/ ...
   (x(1)*G(1, 4) + x(2)*G(2, 4) + x(3)*G(3, 4) + x(4)*G(4, 4)) + ... 
  (x(4)*G(4, 4)*(tau(4, 4) - (x(1)*G(1, 4)*tau(1, 4) + ...
       x(2)*G(2, 4)*tau(2, 4) + x(3)*G(3, 4)*tau(3, 4) + ...
       x(4)*G(4, 4)*tau(4, 4))/(x(1)*G(1, 4) + x(2)*G(2, 4) + x(3)*G(3, 4) + ...
       x(4)*G(4, 4))))/(x(1)*G(1, 4) + x(2)*G(2, 4) + x(3)*G(3, 4) + x(4)*G(4, 4)));
   

Aa(1) = 23.3618; 
Aa(2) = 25.3358;
Aa(3) = 21.7798; 
Aa(4) = 23.4776;
Ba(1) = -4457.83; 
Ba(2) = -4628.96; 
Ba(3) = -3307.73; 
Ba(4) = -3984.92;
Ca(1) = -14.699; 
Ca(2) = -20.514; 
Ca(3) = -39.485; 
Ca(4) = -39.724;

for i=1:4
    Psat(i)=exp((Aa(i) + Ba(i)/(T + Ca(i))));
end

K = 10^(-12.5454 + 3166/(T));

Keq = 8.7;

y2=Psat(2)*GAM(2)*x(2)*1/P*1/(((2*(1-y1+sqrt((1+4*K*P*y1*(2-y1))))))/...
    ((2-y1)*(1+sqrt((1+4*K*P*y1*(2-y1))))));

y3=Psat(3)*GAM(3)*x(3)*1/P/(((2*(1-y1+sqrt((1+4*K*P*y1*(2-y1))))))/...
    ((2-y1)*(1+sqrt((1+4*K*P*y1*(2-y1))))));


Y1=y1+y3;
Y2=y2+y3;


xdot(1)=x(7)-(x(1)+x(3));
xdot(2)=x(8)-(x(2)+x(3));
xdot(3)=1-x(1)-x(2)-x(3)-x(4);
xdot(4)=GAM(1)*GAM(2)*x(1)*x(2)-GAM(3)*GAM(4)*x(3)*x(4)/Keq;
xdot(5)= y1-Psat(1)*GAM(1)*x(1)/((1+sqrt((1+4*K*Psat(1))))/...
    (1+sqrt((1+4*K*P*y1*(2-y1)))))*1/P;
xdot(6)=P-Psat(1)*GAM(1)*x(1)/(((1+sqrt((1+4*K*Psat(1))))/...
    (1+sqrt((1+4*K*P*y1*(2-y1))))))...
    -Psat(2)*GAM(2)*x(2)/(((2*(1-y1+sqrt((1+4*K*P*y1*(2-y1))))))/...
    ((2-y1)*(1+sqrt((1+4*K*P*y1*(2-y1))))))...
    -Psat(3)*GAM(3)*x(3)/(((2*(1-y1+sqrt((1+4*K*P*y1*(2-y1))))))/...
    ((2-y1)*(1+sqrt((1+4*K*P*y1*(2-y1))))))...    
    -Psat(4)*GAM(4)*x(4)/(((2*(1-y1+sqrt((1+4*K*P*y1*(2-y1))))))/...
    ((2-y1)*(1+sqrt((1+4*K*P*y1*(2-y1))))));
xdot(7)=-x(7)+Y1;
xdot(8)=-x(8)+Y2;

xdot = xdot';  % xdot must be a column vector

else
   
% Return M
   M = zeros(8,8);
      M(7,7) = 1;
      M(8,8)= 1;
     
   xdot = M;
end
