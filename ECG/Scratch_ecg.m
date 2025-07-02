% ECG fiducial parameter
%pan tompkins algo

% ai file ta te sob plotgulo kora ache , sudhu P & T ta bade , 

clc
clearvars
close all


file = uigetfile('*.txt');
x1 = load(file);

fname = file (1:end-4);
fname = strcat(fname,'_fiducial.txt');


fs = input('Enter samp;ing freq(Hz):');

N = length(x1); %signal length 
t = (0:N-1)/fs; % time index 


figure(1)
plot(t,x1,'lineWidth',2)
xlabel('time(S)');ylabel('Amp');title('input ECG sig');


%start of pan Tompkins algo
%step 1:DC removal 
x1 = x1-mean(x1);%removal dc comp mean value

% step 2: Normalization 
x1 = x1/max(abs(x1));%normalize :min value 1 


figure(2)
plot(t,x1,'lineWidth',2)
xlabel('time(S)');ylabel('Amp');title('ECG sig after dc removal');



% step 3 : Low pass filtering
b =[1 0 0 0 0 0 -2 0 0 0 0 0 1];%numerator coefficient vector 
a = [1 -2 1]; % denormalization coff vector 
h_LP = filter(b,a,[1 zeros(1,12)]);%transfer fun of LPF
x2 = conv(x1,h_LP);%get filter output 
x2 = x2(6+[1:N]);%calcel dealy 
x2 = x2/max(abs(x2));%normalize

figure(3)
plot(t,x2,'lineWidth',2)
xlabel('time(S)');ylabel('Amp');title('ECG sig after  Low pass filtering');


% step 4 High pass filter 
b = [-1....
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0....
    -32 -32....
    0 0 0 0 0 0 0 0 0 0 0 0 0 0....
    1];
a = [1 -1];
h_HP = filter(b,a,[1 zeros(1,32)]);% unit impulse response of HPF
x3 = conv (x2,h_HP);%time domain conv
x3 = x3(16+[1:N]);% adjust dealy
x3 = x3/max(abs(x3));%normalize
    

figure(4)
plot(t,x3,'lineWidth',2)
xlabel('time(S)');ylabel('Amp');title('ECG sig after  HPF');


%sub plots all graph 

% figure;
% subplot(3,1,1)
% plot(t,x1);%ECG sig after dc removal
% ylabel("1")
% 
% subplot(3,1,2)
% plot(t,x2);%ECG sig after  Low pass filtering
% ylabel("2")
% 
% subplot(3,1,3)
% plot(t,x3);%ECG sig after  HPF
% ylabel("3")


%step 5 : Derivetive filter 
h = [-1 -2 0 2 1]/8; % make impulse response TF 
x4 = conv(x3,h);
x4 = x4(2+[1:N]);% adjust dealy 
x4 = x4/max(abs(x4));% normalize 


figure(5)
plot(t,x4,'lineWidth',2)
xlabel('time(S)');ylabel('Amp');title('ECG sig after  Derivetive filter ');


% step 6 : squaring 
x5 = x4.^2; %element wise squaring 
x5 = x5/max(abs(x5));

%step 7 : moving window integration (MWI)
h= ones(1,31)/31;
Delay = 15;
x6 = conv(x5,h);
x6 = x6(Delay+[1:N]);
x6 = x6/max(abs(x6));


figure(6)
plot(t,x6,'lineWidth',2)
xlabel('time(S)');ylabel('Amp');title('ECG sig after  moving window integration (MWI) ');

% step8 : Detect QRS Regions Pan Tomkins 
max_h = max(x6);
thresh = mean(x6);
poss_reg = (x6>thresh*max_h)';

left = find(diff([0 poss_reg])==1);% rising edge
right = find(diff([poss_reg 0])==-1);%falling edge 

%step 9 :detect QRS peaks pan tompkins

for i=1:length(left)
    [R_value(i),R_loc(i)] = max(x1(left(i):right(i)));
    R_loc(i) = R_loc(i)-1+left(i);%add offset to realign 
    
    [Q_value(i),Q_loc(i)] = min(x1(left(i):R_loc(i)));
     Q_loc(i) = Q_loc(i)-1+left(i);%add offset to realign 
     
     [S_value(i),S_loc(i)] = min(x1(left(i):right(i)));
     S_loc(i) = S_loc(i)-1+left(i);%add offset to realign 


end


Q_loc = Q_loc(find(Q_loc ~=0));%Exclude null valus
R_loc = R_loc(find(R_loc ~=0));
S_loc = S_loc(find(S_loc ~=0));


figure(7)
plot(t*fs,x1,'k',R_loc,R_value,'r^',S_loc,S_value,'y*',....
    Q_loc,Q_value,'mo','Linewidth',2);
aixs auto
legend('ECG','R','S','Q');
title('ECG sig with Q,R,S peaks highlighted ')
xlim([0 1000])