

%% 2.0 Load data...

% either Axon Diameter vs Conduction Velocity
data = readtable('Hursh1936.csv');

% or log-Body Weight vs log-Brain Weight
% data = readtable('BodyBrain.csv');

data = table2array(data);
x = data(:,1);
y = data(:,2);
n = size(data,1);

%% 2.1 Bootstrap to estimate the mean and sem of the x-variable

nboot = 10000;
bootstat = bootstrp(nboot,'mean',x);
figure(1)
subplot(2,1,1)
histogram(x,50,'EdgeColor','none')
xlim([min(x) max(x)])
subplot(2,1,2)
histogram(bootstat,50,'EdgeColor','none')
xlim([min(x) max(x)])

%% 2.2 Plot the data

figure(2)
plot(x,y,'o')

% 2.3 Linear regression

% linear regression
b = polyfit(x,y,1);

% 2.4 Plot the data and fit
yhat = polyval(b,x);

hold on
plot(x,yhat)
hold off

%% 2.5 Bootstrap to find error-bars for the model parameters

nboot = 1000;
for i=1:nboot
    sample_indices = randsample(n,n,true);
    bboot(i,:) = polyfit(x(sample_indices),y(sample_indices),1);
end

figure(3)
subplot(1,2,1)
histogram(bboot(:,1),50)
subplot(1,2,2)
histogram(bboot(:,2),50)

% can also be done in one line...
% bootstat = bootstrp(nboot,'polyfit',x,y,1);

%% Compare different ways of doing linear regression

b = polyfit(x,y,1);

X = [x*0+1 x];

b1 = X\y;
b2 = pinv(X)*y;
b3 = inv(X'*X)*X'*y;
b4 = glmfit(data(:,1),data(:,2),'normal','link','identity');
b5 = regress(data(:,2),X);