% Fig. 9.30   Feedback Control of Dynamic Systems, 5e 
%             Franklin, Powell, Emami
%

clear all;
close all;

h=0.1;
N=1;
nn=1;
nb=nn*nn+1;
ai=0.1:0.001:nn;
NA=(4*N./(pi*ai)).*exp(-sqrt(-1)*asin(h./ai));
subplot(2,1,1)
plot(ai,abs(NA));
grid;
title('Describing function for hysteresis nonlinearity')
xlabel('a');
ylabel('Magnitude, |K_{eq}|');
pause;
ff=180/pi;
subplot(2,1,2)
plot(ai,ff*angle(NA));
grid;
xlabel('a')
ylabel('Phase, \angle K_{eq}, deg')
hold off