%% Plot the response of 1 neuron on the different (L vs R) conditions

neuron=1;

figure(1)
clf
x = 0:max(X(:,neuron));
histogram(X(y==0,neuron),x-.5,'normalization','probability','FaceAlpha',.5);
hold on
mu0 = mean(X(y==0,neuron));
plot(x,poisspdf(x,mu0))

histogram(X(y==1,neuron),x-.5,'normalization','probability','FaceAlpha',.5);
mu1 = mean(X(y==1,neuron));
plot(x,poisspdf(x,mu1),'r')
hold off

legend({'Response during Right','PoissonR','Response during Left','PoissonL'})
xlabel('Spike Count')
ylabel('Probability')

%% Find p(L|spikes) and p(R|spikes) using Bayes rule...

p1_given_s = poisspdf(x,mu1)*0.5;
p0_given_s = poisspdf(x,mu0)*0.5;
ps   = p1_given_s + p0_given_s;
p1gs = p1_given_s./ps;
p0gs = p0_given_s./ps;
hold on
plot(x,p1gs)
plot(x,p0gs)
hold off

%% Fit distributions (calculate means) for all neurons...

muR = mean(X(y==0,:));
muL = mean(X(y==1,:));

%% Calculate p(spikes|L) for all neurons all trials...

for neuron=1:size(X,2)
    for trial=1:size(X,1)
        p1_given_s(trial,neuron) = poisspdf(X(trial,neuron),muL(neuron))*0.5;
        p0_given_s(trial,neuron) = poisspdf(X(trial,neuron),muR(neuron))*0.5;
        ps   = p1_given_s(trial,neuron)+p0_given_s(trial,neuron);
        p1_given_s(trial,neuron) = p1_given_s(trial,neuron)/ps;
        p0_given_s(trial,neuron) = p0_given_s(trial,neuron)/ps;
    end
end

figure(2)
subplot(3,2,[1 3])
% subplot(3,1,1:2)
imagesc(p1_given_s')
set(gca,'TickDir','out'); box off
xlabel('Trial')
ylabel('Neurons')
title('p(L|x)')

%% Use naive bayes assumption

p1_given_S = prod(p1_given_s');
p0_given_S = prod(p0_given_s');
pS   = p1_given_S+p0_given_S;
p1_given_S = p1_given_S./pS;
p0_given_S = p0_given_S./pS;

yhat = p1_given_S';
sum((yhat>0.5)==y)/length(y)

figure(2)
subplot(3,2,5)
plot(p1_given_S,'o')
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

%% Compare naive Bayes and logistic regression with a random number of neurons...

for r=1:size(X,2)
    for rep=1:10
        % Random subset of r neurons
        ridx = randperm(size(X,2));
        ridx = ridx(1:r);
        
        nb = fitcnb(X(:,ridx), y);
        yhat = predict(nb,X(:,ridx));
        accNB(r,rep) = sum((yhat>0.5)==y)/length(y);
        
        b  = glmfit(X(:,ridx),y,'binomial');
        yhat = glmval(b,X(:,ridx),'logit');
        accLR(r,rep) = sum((yhat>0.5)==y)/length(y);
    end
end

figure(2)
subplot(3,2,[2 4 6])
plot(1:size(X,2),mean(accNB'),1:size(X,2),mean(accLR'))
legend({'Naive Bayes','Logistic Regression'})
xlabel('Neurons')
ylabel('Training Accuracy')