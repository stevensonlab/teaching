
% data{dataset_number}.spikes is [neurons x stimulus_conditions x time x repeated_trials]
% data{dataset_number}.conditions contains information about the trial orientation/contrast

dataset_number = 8;

cond1 = 2;  % orientation=0  contrast=100
cond2 = 10; % orientation=90 contrast=100
X1 = squeeze(data{dataset_number}.spikes(:,cond1,:,:));
X2 = squeeze(data{dataset_number}.spikes(:,cond2,:,:));

% total numbers of spikes during the trial
total_X1 = squeeze(sum(X1,2));
total_X2 = squeeze(sum(X2,2));


%% Lab 6.1 - Visualize predictors
% Our goal is to take the activity of all neurons (summed over some time
% range) and discriminate the trials for two specific conditions. We will
% need a [trials x neurons] matrix X that contains the neural activity as
% well as a [trials] vector y that contains the condition identity (0 or 1).

X = ???
y = ???
imagesc(???)

%% Lab 6.2 - Logistic regression

b = glmfit(???); % Fit

%% Lab 6.3 -- Calculate accuracy

yhat = glmval(???); % Predict
acc = ??? % Accuracy

%% 