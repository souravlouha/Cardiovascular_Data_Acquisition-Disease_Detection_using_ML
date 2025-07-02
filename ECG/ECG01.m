% ai file a total ta vhalo kore kora ache , mane final output ta show hobe, with legend 



clc
clearvars
close all

file = uigetfile('*.txt');
x1 = load(file); 

fname = file(1:end-4);
fname = strcat(fname,'_fiducial.txt');

fs = input('Enter sampling rate:');

%fs = 125;              % Sampling rate
N = length (x1);      % Signal length
t = [0:N-1]/fs;        % time index

 
figure(1)
%subplot(2,1,1)
plot(t,x1,'LineWidth',2)
xlabel('Time(S)');ylabel('Amplitude');title('Input ECG Signal')

%subplot(2,1,2)
%lot(t(200:400),x1(200:400))
%label('second');ylabel('Volts');title('Input ECG Signal 1-3 second')
%xlim([1 3])

%%% Cancellation DC drift and normalization

x1 = x1-mean(x1); % Removes the DC component (mean value)
x1 = x1/max(abs(x1)); % Normalize: Maximum absolute value is 1
 
% figure(2)
% %subplot(2,1,1)
% plot(t,x1,'LineWidth',2)
% xlabel('Time(S)');ylabel('Amplitude');title(' ECG Signal after cancellation DC drift and normalization')

%subplot(2,1,2)
%plot(t(200:600),x1(200:600))
%xlabel('second');ylabel('Volts');title(' ECG Signal 1-3 second')
%xlim([1 3])

%%%Low Pass Filtering

% Discrete-time LPF (1-z^-6)^2/(1-z^-1)^2
b=[1 0 0 0 0 0 -2 0 0 0 0 0 1]; %numerator coefficient vector
a=[1 -2 1];
h_LP=filter(b,a,[1 zeros(1,12)]); % transfer function of LPF
x2=conv(x1,h_LP);
%x2 = x2(6+[1: N]); %cancel delay
x2=x2/max(abs(x2)); % normalize

% figure(3)
% %subplot(2,1,1)
% plot([0:length(x2)-1]/fs,x2,'LineWidth',2)
% xlabel('Time(S)');ylabel('Amplitude');title(' ECG Signal after LPF')
% xlim([0 max(t)])

%subplot(2,1,2)

%plot(t(200:600),x2(200:600))
%xlabel('second');ylabel('Volts');title(' ECG Signal 1-3 second')
%xlim([1 3])

%%%High Pass Filtering
% HPF = Allpass-(Lowpass) = z^-16-[(1-z^-32)/(1-z^-1)]
b = [-1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 32 -32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
%b = [-1 fifteen zeroes -32 -32 fourteen zeroes 1];
a = [1 -1];
h_HP=filter(b,a,[1 zeros(1,32)]); % impulse response of HPF
x3 = conv(x2,h_HP);
%x3 = x3(16+[1: N]); %cancel delay
x3 = x3/max(abs(x3));
 
% figure(4)
% %subplot(2,1,1)
% plot([0:length(x3)-1]/fs,x3,'LineWidth',2)
% xlabel('Time(S)');ylabel('Amplitude');title(' ECG Signal after HPF')
% xlim([0 max(t)])

%subplot(2,1,2)
%plot(t(200:600),x3(200:600))
%xlabel('second');ylabel('Volts');title(' ECG Signal 1-3 second')
%xlim([1 3])


%%%%Derivative Filter

% Make impulse response
h = [-1 -2 0 2 1]/8;
% Apply filter
x4 = conv(x3,h);
x4 = x4(2+[1:N]);
x4 = x4/max(abs(x4));
 
% figure(5)
% %subplot(2,1,1)
% plot([0:length(x4)-1]/fs,x4,'LineWidth',2)
% xlabel('second');ylabel('Volts');title(' ECG Signal after Derivative')

%subplot(2,1,2)
%plot(t(200:600),x4(200:600))
%xlabel('second');ylabel('Volts');title(' ECG Signal 1-3 second')
%xlim([1 3])

%Squaring
x5 = x4.^2;
x5 = x5/max(abs(x5));

% figure(6)
% %subplot(2,1,1)
% plot([0:length(x5)-1]/fs,x5,'LineWidth',2)
% xlabel('Time(S)');ylabel('Amplitude');title(' ECG Signal Squarting')

%subplot(2,1,2)
%plot(t(200:600),x5(200:600))
%xlabel('second');ylabel('Volts');title(' ECG Signal 1-3 second')
%xlim([1 3])

%%%Moving Window Integration
% Make impulse response
h = ones(1,31)/31;
Delay = 15; % Delay in samples
% Apply filter
x6 = conv(x5,h);
x6 = x6(15+[1:N]);
x6 = x6/max(abs(x6));
 
figure(7)
%subplot(2,1,1)
plot([0:length(x6)-1]/fs,x6,'LineWidth',2)
xlabel('Time(S)');ylabel('Amplitude');title(' ECG Signal after Averaging')

%subplot(2,1,2)
%plot(t(200:600),x6(200:600))
%xlabel('second');ylabel('Volts');title(' ECG Signal 1-3 second')
%xlim([1 3])

%Find QRS Points Which it is different than Pan-Tompkins algorithm
%figure(7)
%subplot(2,1,1)

max_h = max(x6);
thresh = mean(x6);
poss_reg =(x6>thresh*max_h)';
 
left = find(diff([0 poss_reg])==1); %Rising edge
right = find(diff([poss_reg 0])==-1); %Falling edge
 
left=left-(6+16); % cancel delay because of LP and HP
right=right-(6+16); % cancel delay because of LP and HP

% x6_len = length(x6)+1;
% left = [left x6_len];

% for i=1:length(left)-1
for i=1:length(left) 
    [R_value(i), R_loc(i)] = max(x1(left(i):right(i)));
    R_loc(i) = R_loc(i)-1+left(i); % add offset
 
    [Q_value(i), Q_loc(i)] = min(x1(left(i):R_loc(i)));
    Q_loc(i) = Q_loc(i)-1+left(i); % add offset
 
    [S_value(i), S_loc(i)] = min(x1(left(i):right(i)));
    S_loc(i) = S_loc(i)-1+left(i); % add offset
end

[P_value,P_loc,T_value,T_loc]=augmented_pan_tom(x1,R_loc);

% there is no selective wave

Q_loc=Q_loc(find(Q_loc~=0));
R_loc=R_loc(find(R_loc~=0));
S_loc=S_loc(find(S_loc~=0));
P_loc=P_loc(find(P_loc~=0));
T_loc=T_loc(find(T_loc~=0));
% X_loc=X_loc(find(X_loc~=0));

L=[left' Q_loc'];

figure(7)
%subplot(2,1,1)

%plot (t,x1/max(x1) , t(R_loc) ,R_value , 'r^', t(S_loc) ,S_value, '*',t(Q_loc) , Q_value, 'o','LineWidth',2);
% figure(4);plot(t,sigL,t(Q_t),Q_A,'*g',t(S_t),S_A,'^k',t(R_t),R_A,'ob',t(P_t),P_A,'+b',t(T_t),T_A,'+r');

 plot (t*fs,x1 ,'k', (R_loc) ,R_value , 'r^', (S_loc) ,S_value, 'y*',(Q_loc) , Q_value, 'mo',P_loc,P_value,'b*',T_loc,T_value,'cx','LineWidth',2);
%  plot (t*fs,x1 ,'k', (R_loc) ,R_value , 'r^', (S_loc) ,S_value, 'y*',(Q_loc) , Q_value, 'mo','LineWidth',2);
% plot (t,x1/max(x1) ,'k', (R_loc) ,R_value , 'r^', (S_loc) ,S_value, 'y*',(Q_loc) , Q_value, 'mo',(P_loc),P_value,'b*',(T_loc),T_value,'cx','LineWidth',2);
axis auto
legend('ECG','R','S','Q','P','T');
title('ECG Signal with Q,R,S points highlighted');

%subplot(2,1,2)
%plot (t,x1/max(x1) , t(R_loc) ,R_value , 'r^', t(S_loc) ,S_value, '*',t(Q_loc) , Q_value, 'o');
%xlim([1 3])
% 
% disp('R points:')
% disp('   Time    Amplitude')
% R=[(R_loc*(1/fs))'  R_value' ]
% 
% disp('Q points:')
% disp('   Time    Amplitude')
% Q=[(Q_loc*(1/fs))'  Q_value' ]
% 
% disp('S points:')
% disp('   Time    Amplitude')
% S=[(S_loc*(1/fs))'  S_value' ]
% 
% disp('T points:')
% disp('   Time    Amplitude')
% T=[(T_loc*(1/fs))'  T_value' ]
% 
% disp('P points:')
% disp('   Time    Amplitude')
% P=[(P_loc*(1/fs))'  P_value' ]
% 
% disp('X points:')
% disp('   Time    Amplitude')
% P=[(X_loc*(1/fs))'  X_value' ]

% L=[L(:,1)-2 L(:,2)];

% M=[R Q S T P]
% M=[P Q R S T]
% save(fname,'M','-ascii')


