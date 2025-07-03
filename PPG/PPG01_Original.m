clc
clear variables
close all
 
[fname, path] = uigetfile('*.txt','-ascii');
fname1 = strrep(fname,'.txt',''); %Removes .txt from filename for reuse
fname = strcat(path,fname);

y = load(fname);
y = y(:,2); %Select data column
N = size(y);

txt = sprintf('Total data points available: %d \n', N(1,1));
disp(txt)

l = input('Enter data points required: ');
 
y = y(1:l);
ppg = y;
N = length(ppg);
 
% ppg = ppg*(5/1024);
% b = input('Enter random bias :(0.1-0.8)');
% r = -0.25 + (0.25+0.25)*rand(n(1,1),1);
% r = -b + (b+b)*rand(n(1,1),1);
% ppg1 = ppg+r;
 
% fs = 100; % sampling Frequency of Calcutta University data
fs = 250; % sampling Frequency of mimic III
t = (0:N-1)/fs; % time value conversion

figure(1);
% t1 = 0:1:N-1;
% t1 = t1*(1/125);
plot(t,ppg)
xlabel('Time(S)')
ylabel('Amplitude(V)')
title('Original PPG waveform')
grid on
 
%--------bandpass filtering
fn = fs/2; % Nyquist Frequency
N = 2; %Second order
%[a,b] = butter(N,[0.0025 10]/fn);
%[a,b] = butter(N,[0.0025 10]/fn);
[a,b] = butter(N,[0.03 10]/fn); %Butterworth filter
%freqz(a,b)  
ppg2 = filtfilt(a,b,ppg); %filtfilt avoids phase distortion
 
base = ppg-ppg2; %Baseline = raw signal ? filtered signal
   
N1 = length(ppg2);
t1 = (0:N1-1)/fs;

figure(2);
plot(t1,ppg2,'r','LineWidth',2); 
title('PPG waveform after band-pass filtering');
grid on
xlabel('Time(S)')
ylabel('Amplitude(V)')

%-------Plot both signals in the same window
figure(3);
plot(t,ppg,'LineWidth',2);
xlabel('Time(S)')
ylabel('Amplitude(V)')
title('Original PPG waveform and the filtered PPG waveform')
grid on
hold on
plot(t1,ppg2,'r','LineWidth',2); 
hold off
      
%-------Amplitude normalization through dynamic range matching
MX1 = max(ppg); %Amplitude normalization
MN1 = min(ppg);
D1 = MX1-MN1;
 
MX2 = max(ppg2);
MN2 = min(ppg2);
D2 = MX2-MN2;
 
D = D1/D2;
 
ppg3 = ppg2*D; %Scales the filtered signal so that its...
               %dynamic range matches the original
 
% MX3 = max(ppg3);
% MN3 = min(ppg3);
% D3 = MX3-MN3;
 
ppg4 = ppg3-min(ppg3); %Removes negative amplitude
 
figure(4);
subplot(2,1,1)
plot(t1,ppg-min(ppg),'b','LineWidth',2)
xlabel('Time(S)')
ylabel('Amplitude(V)')
title('Orginal PPG waveform')
subplot(2,1,2)
plot(t1,ppg4,'r',t1,(ppg-min(ppg)-ppg4),'k--','LineWidth',2)
legend('filtered ppg','baseline')
xlabel('Time(S)')
ylabel('Amplitude(V)')
title('BP filtered PPG waveform with removed baseline')
 
fname2 = strcat(fname1,'_filtered.txt');
save(fname2,'ppg4','-ascii')