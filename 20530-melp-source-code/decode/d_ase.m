function [f,state_ase,state_tilt]=d_ase(e,lpcs,G,Gn,u,T,state_ase,state_tilt) 
% ���������� ������������ ���������
% ������� ����������:
%   e         - ������� ������
%   lpcs      - ������������ ��������� ������������
%   G         - �������� ��������
%   Gn        - ������ ������ ����
%   u         - ����������� ��������� �1
%   T         - �������� �������� ��
%   state_ase - ��������� ��������� ��������������� �������
%   state_tilt- ��������� �������� ���������� ������������
% �������� ����������:
%   f         - �������� ������
%   state_ase - �������� ��������� ��������������� �������
%   state_tilt- �������� �������� ���������� ������������

ppp=(G-Gn-12)/18; %����������� p 
% ��������� ������� �����������
if ppp<0 
    ppp=0;
    elseif ppp>1
        ppp=1;
end
% ������ ������������� ��������������� �������
a=0.5*ppp.^(1:10); 
b=0.8*ppp; 
a=[1,a]; 
b=b.^(1:10); 
a=a.*[1,lpcs];  
b=b.*lpcs;     
a=fliplr(a)';   % ��������� ���������� ���������
b=fliplr(b)';   % ��������� ���������� �����������
        
% ��������� ������������ ���������
u=ppp*u; 
% ���������� ������� ����������� � ���������� �������������� �������
buffer=state_ase; 
for i=1:T
    buffer(i+10)=e(i)-buffer(i:i+9)*b; 
    buffer(i)=buffer(i:i+10)*a; 
    f(i)=buffer(i)+u*state_tilt; % ���������� ���������� ������������
    state_tilt=buffer(i); 
end 
state_ase=buffer(T+1:T+10);