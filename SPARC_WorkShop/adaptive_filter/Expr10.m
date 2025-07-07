% Experiment 10 of workshop -- Adaptive noise cancellation

clear all
close all
%Sample frequency
fs1=2000;

%input data
%[data,Fs] = audioread('hospital.wav'); %change this to .wav file of interest
[data,Fs] = audioread('breathing.wav'); %change this to .wav file of interest


%%%BN microphone
 xdn=resample(data(:,2),fs1,Fs);

%%Heart Mic
 ydn=resample(data(:,1),fs1,Fs);
 
%FIRL
FL=512;
mu=0.1;
alp = 0.001;
W=zeros(FL,1);

%%%delay the signal
del=floor(FL/2);
hh=[zeros(1,del),1,zeros(1,del)];
ydn=filter(hh,1,ydn);
pwxdn=var(xdn);
%%%%%%%%%%%%%%%%
DL=max(size(xdn));
RXX=zeros(FL,FL);
rxy=zeros(FL,1);
ryy=0;


%%Adaptive filter
for ii=FL:1:DL
%new sample   
   doe=ydn(ii);
   %update x vector
   x=xdn(ii:-1:ii-FL+1);
   %error history
   en(ii) = doe - W'*x;
   %weight update
   W = (1-alp)*W + mu*conj(x)*en(ii)./norm(x).^2;
end
WLMS=W;

soundsc(en,fs1);
soundsc(ydn,fs1);

%PSD calculated for HM and filtered HM via PSDseg.m function
[psd1, freq1] = PSDseg(ydn, fs1, 20);
[psd2, freq2] = PSDseg(en',fs1,20); 

figure
hold on;
plot(freq1,10*log10(psd1), 'linewidth',1)
hold on
plot(freq2,10*log10(psd2), 'linewidth',1)
hold on
legend('Unfiltered','WLMS')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
xlim([0 1000])
grid on

figure
specgram([xdn;ydn;en'])
caxis([-60 40])
colorbar;
title('Background Noise, Heart Mic, Filtered Signal')

