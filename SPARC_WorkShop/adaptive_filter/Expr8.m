% Experiment 8 of workshop -- Multichannel PCG signal

clear variables

filename = 'normal.wav'; % normal; 
% filename = '3VCAD.wav'; % 3-vessel CAD; 
% filename = '2VCAD.wav'; % 2-vessel CAD; 095
% filename = '1VCAD.wav'; % 1-vessel CAD;

[data, fs] = audioread(filename); %read in .wav file

fs1=2000;
one = resample(data(:,1),fs1,fs);
two = resample(data(:,2),fs1,fs);
four = resample(data(:,4),fs1,fs);
five = resample(data(:,5),fs1,fs);
six = resample(data(:,6),fs1,fs);
sev = resample(data(:,7),fs1,fs);
eig = resample(data(:,8),fs1,fs);
ecg = resample(data(:,11),fs1,fs);

low=20;
high=950;

one = bandpass(one, [low high], fs1);
two = bandpass(two, [low high], fs1);
four = bandpass(four, [low high], fs1);
five = bandpass(five, [low high], fs1);
six = bandpass(six, [low high], fs1);
sev = bandpass(sev, [low high], fs1);
eig = bandpass(eig, [low high], fs1);
ecg = bandstop(ecg, [45 55], fs1);

figure
subplot(8,1,1)
plot(one(400:end))
ylabel("1")
subplot(8,1,2)
plot(two(400:end))
ylabel("2")
subplot(8,1,3)
plot(four(400:end))
ylabel("3")
subplot(8,1,4)
plot(five(400:end))
ylabel("4")
subplot(8,1,5)
plot(six(400:end))
ylabel("5")
subplot(8,1,6)
plot(sev(400:end))
ylabel("6")
subplot(8,1,7)
plot(eig(400:end))
ylabel("BACK")
subplot(8,1,8)
plot(ecg(400:end))
ylabel('ECG')