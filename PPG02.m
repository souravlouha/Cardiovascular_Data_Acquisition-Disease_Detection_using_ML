clc
clear variables
close all
[fname,path] = uigetfile('*.txt','-ascii');
fname1 = strrep(fname,'.txt',''); %removes .txt from name
fname2 = strcat(fname1,'filtered','_ppg_beat_matrix.txt');

ppg = load(fname);
M = mean(ppg);

N=length(ppg);
fs = 250; %Samnpling frequency;
t = 0:1:N-1;%Construct time vector
t = t*(1/fs);
t=t';

ppg_mean = ppg - M; %Mean removal

% Detect Maxima (Systolic Peak)
[max_peak,loc1]= findpeaks(ppg_mean,t,'MinPeakDistance',0.35);

% Detect Minimum(Crests/Valleys)
ppg_inverted = -ppg_mean;
[min_peak,loc2] = findpeaks(ppg_inverted,t,'MinPeakDistance',0.25);

%Detect Diastolic Peak
diastolic_peak_vals = [];
diastolic_peak_locs = [];

for i=1:length(loc1)
    t_sys = loc1(i); %time instant of the sysrolic peak
    idx_sys = round(t_sys*fs); % Sample index of systolic peak
    
    %search window
    idx_start = max(idx_sys-round(0.3*fs),1);
    idx_end = max(idx_sys-round(0.1*fs),1);
    
    
    %skip if the window is to small
    if idx_end <=(idx_start +3)
        continue
    end
    
    window_sig = ppg(idx_start:idx_end);
    window_t= t(idx_start:idx_end);
    [pks,locs] = findpeaks(window_sig);
    
    if ~isempty(pks)
        %Take the last peek in window(closet before systolic)
        diastolic_peak_vals(end+1)=pks(end);
        diastolic_peak_locs(end+1)=window_t(locs(end));
    end 
end


figure(1);
plot(t,ppg,'b-','LineWidth',1.5);
hold on
xlabel('Time (S)')
ylabel('Amplitude(V)')
title('PPC signal with systolic peak, Dicrotic Notch, end Diastolic Peak');
grid on
%place the systolic peaks on plot
plot(loc1,max_peak+M,'ro','MarkerFaceColor','r');
for i=1:length(loc1)
    text(loc1(i),max_peak(i)+M+0.02,'S','Color','r','FontSize',8,'HorizontalAlignment','center');
end

%place the dicrotic notches on plot
min_peak = -min_peak; %Restore the original sign
% %Filter the unwanted, extra peaks
% epsilon_time = 0.3;
% to_remove = false(size(loc2));
% for i = 1:length(diastolic_peak_locs)
%     diffs = abs(locs - diastolic_peak_locs(i));
%     to_remove = to_remove |(diffs<epsilon_time);
% end
% loc2_filtered = loc2(~to_remove);
% min_peak_filtered = min_peak(~to_remove);

plot(loc2,min_peak + M,'go','MarkerFaceColor','g');
for i=1:length(loc2)
    text(loc2(i),min_peak(i)+M-0.03,'C','Color','g','FontSize',8,'HorizontalAlignment','center');
end




