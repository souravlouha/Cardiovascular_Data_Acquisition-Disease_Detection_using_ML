clc
clear variables
close all

[fname, path] = uigetfile('*.txt','-ascii');
fname1 = strrep(fname,'.txt','');
fname2 = strrep(fname1,'filtered','_ppg_beat_matrix.txt');

%**************************
%select the filtered file *
% enter 14000 ----------- *
%                         *
%**************************
%filtfilt is the filter design



ppg = load(fname);
M = mean(ppg);

N = length(ppg);
t = 0:1:N-1; %Constructs time vector
t = t*(1/250); %Sampling frequency = 250 Hz
t = t';

ppg_mean = ppg-M;

%-----Detect Maxima (Systolic Peaks)
%[max_peak,loc1] = findpeaks(ppg,t,'MinPeakDistance',0.25);
[max_peak,loc1] = findpeaks(ppg_mean,t,'MinPeakDistance',0.35);

%-----Detect Minima (Crests / Valleys)
ppg_inverted = -ppg_mean;
%[min_peak,loc2] = findpeaks(ppg_inverted,t,'MinPeakDistance',0.1,'MinPeakWidth',0.2);
[min_peak,loc2] = findpeaks(ppg_inverted,t,'MinPeakDistance',0.25);

%-----Detect Diastolic Peaks after Systolic
diastolic_peak_vals = [];
diastolic_peak_locs = [];

for i = 1:length(loc1)
    t_sys = loc1(i);           % time of systolic peak
    idx_sys = round(t_sys * 250);  % sample index

    % search window: 0.3s to 0.1s before systolic
    idx_start = max(idx_sys - round(0.3 * 250), 1);
    idx_end = max(idx_sys - round(0.1 * 250), 1);

    % Skip if window is too small
    if idx_end <= idx_start + 3
        continue
    end

    window_sig = ppg(idx_start:idx_end);
    window_t = t(idx_start:idx_end);

    [pks, locs] = findpeaks(window_sig);
    if ~isempty(pks)
        % Take the last peak in the window (closest before systolic)
        diastolic_peak_vals(end+1) = pks(end);
        diastolic_peak_locs(end+1) = window_t(locs(end));
    end
end

figure(1)
plot(t, ppg, 'b-', 'LineWidth', 1.5); 
hold on;
xlabel('Time (s)');
ylabel('Amplitude');
title('PPG Signal with Systolic Peak, Dicrotic Notch, and Diastolic Peak');
grid on

% Place the Systolic Peaks on the plot
plot(loc1, max_peak + M, 'ro', 'MarkerFaceColor', 'r');
for i = 1:length(loc1)
    text(loc1(i), max_peak(i) + M + 0.02, 'S', 'Color', 'r', 'FontSize', 8, 'HorizontalAlignment', 'center');
end

% Place the Dicrotic Notches (valleys) on the plot
min_peak = -min_peak;  % restore sign

%------Remove min_peaks near diastolic peaks
epsilon_time = 0.3;  % 0.3 seconds before systolic peak
to_remove = false(size(loc2));
for i = 1:length(diastolic_peak_locs)
    % Mark any min_peak within epsilon_time of diastolic_peak
    diffs = abs(loc2 - diastolic_peak_locs(i));
    to_remove = to_remove | (diffs < epsilon_time);
end
% Keep only the true dicrotic notch
loc2_filtered = loc2(~to_remove);
min_peak_filtered = min_peak(~to_remove);

% Place the Dicrotic Notches on the plot
% plot(loc2, min_peak + M, 'go', 'MarkerFaceColor', 'g');
% for i = 1:length(loc2)
%     text(loc2(i), min_peak(i) + M - 0.03, 'C', 'Color', 'g', 'FontSize', 8, 'HorizontalAlignment', 'center');
% end

% Place the Dicrotic Notches (filtered) on the plot
plot(loc2_filtered, min_peak_filtered + M, 'go', 'MarkerFaceColor', 'g');
for i = 1:length(loc2_filtered)
    text(loc2_filtered(i), min_peak_filtered(i) + M - 0.03, 'Dr', 'Color', 'g', ...
        'FontSize', 8, 'HorizontalAlignment', 'center');
end


% Place the Diastolic Peaks (before systolic) on the plot
plot(diastolic_peak_locs, diastolic_peak_vals, 'mo', 'MarkerFaceColor', 'm');
for i = 1:length(diastolic_peak_locs)
    text(diastolic_peak_locs(i), diastolic_peak_vals(i) + 0.02, 'D', 'Color', 'm', 'FontSize', 8, 'HorizontalAlignment', 'center');
end

legend('PPG', 'Systolic Peak', 'Dicrotic Notch', 'Diastolic Peak');
%xlim([0 10])
hold off
% hgsave('peak_crest') %Save the current figure

p1 = length(max_peak); %Number of detected peaks
p2 = length(min_peak); %Number of detected crests

%----Segment Signal into Beats
num_beats = p2 - 1;
BEAT_CELL = cell(1, num_beats);
beat_lengths = zeros(1, num_beats); % Preallocate length array

for k = 1:num_beats
    M1 = round(loc2(k) * 250);     % Convert time to index
    M2 = round(loc2(k+1) * 250);   % Convert time to index
    beat = ppg(M1:M2);
    BEAT_CELL{k} = beat;
    beat_lengths(k) = length(beat);
end

%----- Find maximum beat length and zero-pad others
max_length = max(beat_lengths);
for k = 1:num_beats
    beat = BEAT_CELL{k};
    pad_len = max_length - length(beat);
    BEAT_CELL{k} = [beat; zeros(pad_len, 1)];
end

%----- Combine into matrix
BEAT = zeros(max_length, num_beats);
for k = 1:num_beats
    BEAT(:, k) = BEAT_CELL{k};
end

fname2 = strcat(path,fname2);
save(fname2,'BEAT','-ascii','-tabs') %Use -tabs to separate values

fprintf('Total No. of Beats:%d\n',k);