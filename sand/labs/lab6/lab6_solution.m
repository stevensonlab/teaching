
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

% Concatenate predictor matrices
X =[total_X1 total_X2]';
% Concatenate response vector
y1 = ones(size(total_X1,2),1);
y2 = zeros(size(total_X2,2),1);
y  = [y1; y2];

figure(1)
imagesc(X);
line(xlim(),[1 1]*size(total_X1,2),'Color','r')
xlabel('Neurons')
ylabel('Trials')

% see neuron 5 vs neuron 6
figure(2)
gscatter(X(:,5),X(:,6),y)
xlabel('Neuron 5')
ylabel('Neuron 6')

%% Lab 6.2 - Logistic regression

b = glmfit(X,y,'binomial'); % Fit

%% Lab 6.3 -- Calculate accuracy

yhat = glmval(b,X,'logit'); % Predict
sum((yhat>0.5)==y)/length(y) % Accuracy

%% BONUS Cross-validation
cross_validation = cvpartition(size(X,1),'KFold',10);
yhat=y*NaN;
for cvk = 1:cross_validation.NumTestSets
	b = glmfit(X(cross_validation.training(cvk),:),y(cross_validation.training(cvk)),'binomial'); % Fit
	yhat(cross_validation.test(cvk)) = glmval(b,X(cross_validation.test(cvk),:),'logit'); % Predict
end
sum((yhat>0.5)==y)/length(y) % Accuracy

%% BONUS LDA
class = classify(X,X,y,'linear');
sum(class==y)/length(y) % Accuracy


%% BONUS accuracy over time

cond1 = 2;
cond2 = 10;

X1 = squeeze(data{dataset_number}.spikes(:,cond1,:,:));
X2 = squeeze(data{dataset_number}.spikes(:,cond2,:,:));

figure(3)

% Two conditions to compare
cond1 = 1;
cond2 = 9;

% Loop over time
acc = [];
for t=4:90
    % Concatenate predictor matrix
    X1 = squeeze(sum(data{dataset_number}.spikes(:,cond1,t-3:t,:),3))';
    X2 = squeeze(sum(data{dataset_number}.spikes(:,cond2,t-3:t,:),3))';
    X = [X1; X2];

    % Concatenate response vector
    y1 = ones(size(X1,1),1);
    y2 = zeros(size(X2,1),1);
    y  = [y1; y2];

    % Fit
    b = glmfit(X,y,'binomial');
    % Predict
    yhat = glmval(b,X,'logit');

    % Get accuracy
    acc(t) = sum((yhat>0.5)==y)/length(y);
end
acc(1:3)=NaN;

plot(data{dataset_number}.times,acc)
xlabel('Time')
ylabel('Accuracy')

% Two conditions to compare
cond1 = 2;
cond2 = 10;

% Loop over time
acc = [];
for t=4:90
    % Concatenate predictor matrix
    X1 = squeeze(sum(data{dataset_number}.spikes(:,cond1,t-3:t,:),3))';
    X2 = squeeze(sum(data{dataset_number}.spikes(:,cond2,t-3:t,:),3))';
    X = [X1; X2];

    % Concatenate response vector
    y1 = ones(size(X1,1),1);
    y2 = zeros(size(X2,1),1);
    y  = [y1; y2];

    % Fit
    b = glmfit(X,y,'binomial');
    % Predict
    yhat = glmval(b,X,'logit');

    % Get accuracy
    acc(t) = sum((yhat>0.5)==y)/length(y);
end
acc(1:3)=NaN;

hold on
plot(data{dataset_number}.times,acc)
hold off
legend({'10% Contrast','100% Contrast'})
box off; set(gca,'TickDir','out')