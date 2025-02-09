function kalman()
clear,clc

%***********Real Time************************
    %vid = videoinput('winvideo', 1,'RGB24_320x240');
    vid = videoinput('winvideo', 1);
    set(vid,'FramesPerTrigger',1);
    set(vid,'TriggerRepeat',Inf);
    triggerconfig(vid, 'Manual');
    start(vid);
    trigger(vid);
     Imzero = zeros(480,640,3);
%***********************************
    
% compute the background image
% 
%  Imzero = zeros(240,320,3);
for i = 1:5
    Im{i} = double(imread([int2str(i),'.jpg']));
    Imzero = Im{i}+Imzero;
end
% Imback = Imzero/5;
% [MR,MC,Dim] = size(Imback);

%*****************Real Time*****************************
%          trigger(vid);
%         Im{1} = (getdata(vid,1,'double'));
%          trigger(vid);
%         Im{2} = (getdata(vid,1,'double'));
%          trigger(vid);
%         Im{3} = (getdata(vid,1,'double'));
%          trigger(vid);
%         Im{4}= (getdata(vid,1,'double'));
%          trigger(vid);
%         Im{5} = (getdata(vid,1,'double'));
% %         
%         Imzero = Im{1}+Imzero;
%         Imzero = Im{2}+Imzero;
%         Imzero = Im{3}+Imzero;
%         Imzero = Im{4}+Imzero;
%         Imzero = Im{5}+Imzero;
        Imback = Imzero/5;
        [MR,MC,Dim] = size(Imback);
%*********************************************************



% Kalman filter initialization
R=[[0.2845,0.0045]',[0.0045,0.0455]'];
H=[[1,0]',[0,1]',[0,0]',[0,0]'];
Q=0.01*eye(4);
P = 100*eye(4);
dt=1;
A=[[1,0,0,0]',[0,1,0,0]',[dt,0,1,0]',[0,dt,0,1]'];
g = 6; % pixels^2/time step
Bu = [0,0,0,g]';
kfinit=0;
x=zeros(100,4);

% loop over all images
for i = 1 : 20
  % load image
% %**************Real Time********************
   trigger(vid);
   
  Im = (getdata(vid,1,'double')); 
  Imwork = double(Im);
  imshow(Im);
 
  
% %*********************************

%   Im = (imread([int2str(i), '.jpg'])); 
%   imshow(Im)
%   Imwork = double(Im);

  %extract ball
  [cc(i),cr(i),radius,flag] = extractball(Imwork,Imback,i);
  if flag==0
    continue
  end

  hold on
    for c = -1*radius: radius/20 : 1*radius
      r = sqrt(radius^2-c^2);
      plot(cc(i)+c,cr(i)+r,'g.')
      plot(cc(i)+c,cr(i)-r,'g.')
    end
  % Kalman update
i
  if kfinit==0
    xp = [MC/2,MR/2,0,0]'
  else
    xp=A*x(i-1,:)' + Bu
  end
  kfinit=1;
  PP = A*P*A' + Q
  K = PP*H'*inv(H*PP*H'+R)
  x(i,:) = (xp + K*([cc(i),cr(i)]' - H*xp))';
  x(i,:)
  [cc(i),cr(i)]
  P = (eye(4)-K*H)*PP

  hold on
    for c = -1*radius: radius/20 : 1*radius
      r = sqrt(radius^2-c^2);
      plot(x(i,1)+c,x(i,2)+r,'r.')
      plot(x(i,1)+c,x(i,2)-r,'r.')
    end
      pause(0.3)
end

% show positions
  figure
  plot(cc,'r*')
  hold on
  plot(cr,'g*')
%end
stop(vid);
%estimate image noise (R) from stationary ball
  posn = [cc(10:15)',cr(10:15)'];
  mp = mean(posn);
  diffp = posn - ones(6,1)*mp;
  Rnew = (diffp'*diffp)/5;
  