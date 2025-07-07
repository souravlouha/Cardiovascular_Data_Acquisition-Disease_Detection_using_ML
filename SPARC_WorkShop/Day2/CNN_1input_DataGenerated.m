clear all
close all

load('Springer_B_matrix.mat');
load('Springer_pi_vector.mat');
load('Springer_total_obs_distribution.mat');

Nfile = 200;  % number of files in training and validation
nfb = 1;        % single frequency bands
ncycle = 5; % number of heart beat cycles in each file
nsamp = 2500;   % number of samples in each heart beat cycle.
ntrain = Nfile*ncycle;  % number of training and validation samples

Xall = zeros(nfb,nsamp,1,ntrain);
Yall = zeros(ntrain,1);

load CNN_1input.mat;
%% Form DNN layers
Layer1 = [imageInputLayer([nfb nsamp],'Name','input1')
    convolution2dLayer([1 5],8,'stride',1,'Name','conv11')
    reluLayer('Name','relu11')
    maxPooling2dLayer([1 2],'Name','pooling11')
    convolution2dLayer([1 5],4,'stride',1,'Name','conv12')
    reluLayer('Name','relu12')
    maxPooling2dLayer([1 2],'Name','pooling12')
    dropoutLayer(0.25,'Name','drop1')];

concat = concatenationLayer(3,2,'Name','concat');
lgraph = layerGraph();
lgraph = addLayers(lgraph, Layer1);

LayerLast= [fullyConnectedLayer(20,'name','fc1')
            reluLayer('Name','relu3')
            dropoutLayer(0.5,'Name','drop3')
            fullyConnectedLayer(2,'name','fc2')
            softmaxLayer('Name','softmx')
            classificationLayer('Name','cl')];

lgraph = addLayers(lgraph, LayerLast);
lgraph = connectLayers(lgraph,'drop1','fc1');

figure
plot(lgraph)
 
MaxEpochs = 50;
MiniBatchSize = 50;

%% Define trainig options 'ValidationData',{Xvalid,Yvalid}, ...
Options = trainingOptions('adam',...
    'InitialLearnRate',0.01,...
    'ValidationData',{Xvalid,Yvalid}, ...
    'ExecutionEnvironment','auto', ...
    'GradientThreshold',1, ...
    'LearnRateDropFactor',0.1,...
    'MaxEpochs',MaxEpochs, ...
    'MiniBatchSize',MiniBatchSize, ...
    'Shuffle','every-epoch', ...
    'Verbose',0,...
    'Plots','training-progress');
%% Train DNN
Net = trainNetwork(Xtrain,Ytrain,lgraph,Options);

function idx_states = get_states(assigned_states)
    indx = find(abs(diff(assigned_states))>0); % find the locations with changed states

    if assigned_states(1)>0   % for some recordings, there are state zeros at the beginning of assigned_states
        switch assigned_states(1)
            case 4
                K=1;
            case 3
                K=2;
            case 2
                K=3;
            case 1
                K=4;
        end
    else
        switch assigned_states(indx(1)+1)
            case 4
                K=1;
            case 3
                K=2;
            case 2
                K=3;
            case 1
                K=0;
        end
        K=K+1;
    end

    indx2                = indx(K:end);
    rem                  = mod(length(indx2),4);
    indx2(end-rem+1:end) = [];
    idx_states           = reshape(indx2,4,length(indx2)/4)';
end