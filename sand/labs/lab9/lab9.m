%% Part 1: Plot the distribution of responses of 1 neuron under the different (L vs R) conditions

neuron=1;

figure(1)
clf
x = 0:max(X(:,neuron));
% histogram(X(???),x-.5,'normalization','probability','FaceAlpha',.5);
hold on
% mu0 = ???;
% plot(x,poisspdf(???))

% histogram(X(???),x-.5,'normalization','probability','FaceAlpha',.5);
% mu1 = ???;
% plot(x,poisspdf(???),'r')
hold off

legend({'Response during Left','Response during Right'})
xlabel('Spike Count')
ylabel('Probability')

%% Part 2: Find p(L|spikes) and p(R|spikes) using Bayes rule...

% p1gx = poisspdf(???)*???;
% p0gx = poisspdf(???)*???;
% px   = ???;
% p1gx = ???;
% p0gx = ???;
hold on
plot(x,p1gx)
plot(x,p0gx)
hold off

%% Par 3: 


% Fit distributions (calculate means) for all neurons...
mu0 = mean(X(y==0,:));
mu1 = mean(X(y==1,:));

% Calculate p(spikes|L) for all neurons all trials...
for neuron=1:size(X,2)
    for trial=1:size(X,1)
%         p1gx(trial,neuron) = poisspdf(???)*???;
%         p0gx(trial,neuron) = poisspdf(???)*???;
%         px   = ???;
%         p1gx(trial,neuron) = ???;
%         p0gx(trial,neuron) = ???;
    end
end

% Use naive bayes assumption
% p1gX = ???;
% p0gX = ???;
% pX   = ???;
% p1gX = ???;
% p0gX = ???;

% evaluate the accuracy
yhat = p1gX';
sum((yhat>0.5)==y)/length(y)

% generate figure
figure(2)
subplot(3,1,1:2)
% imagesc(???)
set(gca,'TickDir','out'); box off
xlabel('Trial')
ylabel('Neurons')
title('p(L|x)')
subplot(3,2,5)
plot(p1gX,'o')
xlabel('Trial')
ylabel('p(L|x)')
ylim([0 1]); 
set(gca,'TickDir','out'); box off
axis tight

%% The code above gives some practice working with Bayes rule...
% but Matlab has some built-in functions for naive Bayes classification
% the default is to fit Gaussians rather than Poisson.

nb = fitcnb(X, y);
yhat = predict(nb,X);
sum((yhat>0.5)==y)/length(y)

%% Part 4: Compare naive Bayes and logistic regression with a random subset of neurons...

for r=1:size(X,2)
    for rep=1:10
        % Random subset of r neurons
        ridx = randperm(size(X,2));
        ridx = ridx(1:r);
        
%         nb = fitcnb(???);
        yhat = predict(nb,X(:,ridx));
        accNB(r,rep) = sum((yhat>0.5)==y)/length(y);
        
%         b  = glmfit(???);
        yhat = glmval(b,X(:,ridx),'logit');
        accLR(r,rep) = sum((yhat>0.5)==y)/length(y);
    end
end

figure(3)
plot(1:size(X,2),mean(accNB'),1:size(X,2),mean(accLR'))
legend({'Naive Bayes','Logistic Regression'})
xlabel('Neurons')
ylabel('Training Accuracy')