clear variables
%RUN SECTION BY SECTION
%% Feature Extraction

%first we load the PCG database. Each cell of 'normal_pcg' and
%'abnormal_pcg' contains a PCG signal
%fs is the sampling frequency
load("PCG_database.mat")

%next we find the number of signals in the balanced dataset
no_pcg = length(normal_pcg);

% reshuffle data %%%%%%%%%%%%%%%%%
file_order= randperm(no_pcg);
for i=1:no_pcg
    normal_pcg_1{i,1}= normal_pcg{file_order(i),1};
    abnormal_pcg_1{i,1}= abnormal_pcg{file_order(i),1};
end
clearvars normal_pcg abnormal_pcg
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

normal_pcg = normal_pcg_1;
abnormal_pcg = abnormal_pcg_1;

%extract PSD based features
%the features will be the power accross a defined sub-band width (SBW)
SBW = 10; %change this value to see its effects on the results
TBW = 1000; %Total bandwidth we will extract features from (Hz)

per_train = 0.7;    % training-test split
per_test = 0.3;

ind_BW = 25:SBW:TBW; %this will be used for feature extraction - obtaining power from each subband up to the total bandwidth

%we initialise our feature-matrix. Each row represents a subject, and each
%column a feature
%We can determine how many features there will be based on SBW and TBW

feat_NOR = zeros(no_pcg, length(ind_BW)-1);
feat_ABN = zeros(no_pcg, length(ind_BW)-1);
for sub = 1:no_pcg

    %extract the relevant PCG signal for both classes
    PCG_NOR = zscore(normal_pcg{sub,1});
    PCG_ABN = zscore(abnormal_pcg{sub,1});

    %we use the Pwelch method to extract the PSD from each signal
    w = 1024; %window size for pwelch method (samples)
    [psd_NOR, freq]    = pwelch(PCG_NOR, hanning(w), w/2 ,w ,fs); clearvars PCG_NOR
    [psd_ABN, ~]    = pwelch(PCG_ABN, hanning(w), w/2 ,w ,fs); clearvars PCG_ABN

    %this produces w/2+1 frequency bins (frequency values stored in 'freq,
    % values stored in psd_NOR,psd_ABN

    %now we extract features - power accross pre-defined sub-band width
    %(SBW)
    
    %first we initiliase the current subjects feature vector
    E_NOR = zeros(1,length(ind_BW)-1);
    E_ABN = zeros(1,length(ind_BW)-1);
    for i = 1:length(ind_BW)-1
        ind_l = find(freq>=ind_BW(i),1); % this tells us which indicies correspond to the particular subband
        ind_h = find(freq<= ind_BW(i+1),1,'last');

        %Now we calculate the energy in the band, and store in the variable
        E_NOR(i) = trapz(freq(ind_l:ind_h), psd_NOR(ind_l:ind_h)); %area under the curve
        E_ABN(i) = trapz(freq(ind_l:ind_h), psd_ABN(ind_l:ind_h)); %area under the curve

    end
    
    clearvars psd_NOR psd_ABN

    %Now we add the features to the feature matrix
    feat_NOR(sub,:) = E_NOR; clearvars E_NOR
    feat_ABN(sub,:) = E_ABN; clearvars E_ABN

end


%% Classification using SVM

%We have feat_NOR and feat_ABN. We till take 80% of the subjects (rows)
%from each and concatenate into a training matrix
%The remaining 20% will be used for the testing matrix

no_nor_sub = size(feat_NOR,1);
no_abn_sub = size(feat_ABN,1);
training_matrix = [feat_NOR(1:floor(per_train*no_nor_sub),:);
                    feat_ABN(1:floor(per_train*no_abn_sub),:)];
%we now make our label vector - 0 for normal and 1 for abnormal
training_labels = [zeros(floor(per_train*no_nor_sub),1);
                    ones(floor(per_train*no_abn_sub),1)];

testing_matrix = [feat_NOR(floor(per_train*no_nor_sub)+1:end,:);
                    feat_ABN(floor(per_train*no_abn_sub)+1:end,:)];

test_labels = [zeros(floor(per_test*no_nor_sub),1);
                    ones(floor(per_test*no_abn_sub),1)];

%verify that the label vectors are correct and correspond to the correct
%rows in the feature matricies

%now we train the SVM below

SVMModel = fitcsvm(training_matrix,training_labels) %The details will appear in the Command Window
%visit
% https://au.mathworks.com/help/stats/fitcsvm.html
% to explore more - and try different things!

%% TESTING
%We can test below

[output_labels,score] = predict(SVMModel,testing_matrix);

[accuracy, sensitivity, specificity] = calculate_metrics(test_labels, output_labels); %open function to see how this works

disp('Accuracy %:')
disp(accuracy*100)

disp('Sensitivity %:')
disp(sensitivity*100)

disp('Specificity %:')
disp(specificity*100)