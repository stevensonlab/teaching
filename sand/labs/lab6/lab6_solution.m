dataset_number = 8;


cond1 = 2; % 0deg at 100% contrast
cond2 = 10; % 90deg at 100% contrast
X1 = squeeze(data{dataset_number}.spikes(:,cond1,:,:));
X2 = squeeze(data{dataset_number}.spikes(:,cond2,:,:));

X1 = squeeze(sum(X1,2));
X2 = squeeze(sum(X2,2));
figure(2)
neuron=5;
plot([X1(neuron,:) X2(neuron,:)],rand(1,size(X1,2)*2)/10+[X1(neuron,:)*0 X2(neuron,:)*0+1],'o')

%%
figure(1)
subplot(1,2,1)
imagesc([X1 X2]');
line(xlim(),[1 1]*size(X1,2),'Color','r')
xlabel('Neurons')
ylabel('Trials')

%%
X = [X1 X2]';
% X = X(:,1:5);
% Concatenate response vector
y1 = ones(size(X1,2),1);
y2 = zeros(size(X2,2),1);
y  = [y1; y2];

% Fit all of the data...
b = glmfit(X,y,'binomial'); % Fit
yhat = glmval(b,X,'logit'); % Predict
sum((yhat>0.5)==y)/length(y) % Accuracy
%%
% Cross-validation
cross_validation = cvpartition(size(X,1),'KFold',10);
yhat=y*NaN;
for cvk = 1:cross_validation.NumTestSets
	b = glmfit(X(cross_validation.training(cvk),:),y(cross_validation.training(cvk)),'binomial'); % Fit
	yhat(cross_validation.test(cvk)) = glmval(b,X(cross_validation.test(cvk),:),'logit'); % Predict
end
sum((yhat>0.5)==y)/length(y) % Accuracy

%% compare over time


cond1 = 2;
cond2 = 10;

X1 = squeeze(data{dataset_number}.spikes(:,cond1,:,:));
X2 = squeeze(data{dataset_number}.spikes(:,cond2,:,:));

figure(1)
subplot(1,2,1)
imagesc([squeeze(sum(X1,2))'; squeeze(sum(X2,2))']);
line(xlim(),[1 1]*size(X1,3),'Color','r')
xlabel('Neurons')
ylabel('Trials')
subplot(1,2,2)

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