% Experiment 12 of workshop -- Wiener filter noise cancellation + HP
% filtering

clear all
%close all
%Sample frequency
fs1=2000;

%input data
[data,Fs] = audioread('hospital.wav'); %change this to .wav file of interest


%%%BN microphone
 xdn1=resample(data(:,2),fs1,Fs);
 xdn= highpass(xdn1,50,fs1);

%%Heart Mic
 ydn=resample(data(:,1),fs1,Fs);
 
%FIRL
FL=256;
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


%%Wiener filter
%calculate correlation matrix and crosscorrelation vector
for ii=FL:1:DL
   xv=xdn(ii:-1:ii-FL+1);
   RXX=RXX+xv*xv';
   rxy=rxy+xv*ydn(ii);
   ryy=ryy+ydn(ii)^2;
   yp(ii)=ydn(ii);
end

%find optimal weights
err0 = 0.05;

w =(RXX+err0*max(eig(RXX))*eye(size(RXX)))\rxy;
err= (ryy-2*w'*rxy+w'*RXX*w)/(DL-FL);

iter = 0;
while abs(err0-err) > 0.00001
    iter = iter+1;
    w=(RXX+err*max(eig(RXX))*eye(size(RXX)))\rxy;
    err0=err;
    err=(ryy-2*w'*rxy+w'*RXX*w)/(DL-FL);
end

yhat=filter(w,1,xdn(1:DL));
en1=yp'-yhat;

soundsc(en1,fs1);
soundsc(yp,fs1);

%PSD calculated for HM and filtered HM via PSDseg.m function
[psd1, freq1] = PSDseg(ydn, fs1, 20);
[psd2, freq2] = PSDseg(en1,fs1,20); 

figure
hold on;
plot(freq1,10*log10(psd1), 'linewidth',1)
hold on
plot(freq2,10*log10(psd2), 'linewidth',1)
hold on
legend('Unfiltered','Wiener')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
xlim([0 1000])
grid on

figure
specgram([xdn1;ydn;en1])
caxis([-60 40])
colorbar;
title('Background Noise, Heart Mic, Filtered Signal')