

%% 2.0 Load data...

% either Axon Diameter vs Conduction Velocity
data = readtable('Hursh1936.csv');

% or log-Body Weight vs log-Brain Weight
data = readtable('BodyBrain.csv');

data = table2array(data);

%% 2.1 Bootstrap to estimate the mean and sem of the x-variable

nboot = 10000;
bootstat = bootstrp(nboot,'mean',data(:,1));
figure(1)
subplot(2,1,1)
histogram(data(:,1),50,'EdgeColor','none')
xlim([min(data(:,1)) max(data(:,1))])
subplot(2,1,2)
histogram(bootstat,50,'EdgeColor','none')
xlim([min(data(:,1)) max(data(:,1))])

%% 2.2 Plot the data

figure(2)
plot(data(:,1),data(:,2),'o')

% 2.3 Linear regression

% linear regression
b = polyfit(data(:,1),data(:,2),1);

% 2.4 Plot the data and fit
yhat = polyval(b,data(:,1));

hold on
plot(data(:,1),yhat)
hold off

%% 2.5 Bootstrap to find error-bars for the model parameters

nboot = 1000;
[bootstat,bootsam] = bootstrp(nboot,'',1:size(data,1));
for i=1:nboot
    idx = bootsam(:,i);
    bboot(i,:) = polyfit(data(idx,1),data(idx,2),1);
end

figure(3)
subplot(1,2,1)
histogram(bboot(:,1),50)
subplot(1,2,2)
histogram(bboot(:,2),50)

%% Compare different ways of doing linear regression

b = polyfit(data(:,1),data(:,2),1);

X = [data(:,1)*0+1 data(:,1)];
y = data(:,2);

b1 = X\y;
b2 = pinv(X)*y;
b3 = inv(X'*X)*X'*y;
b4 = glmfit(data(:,1),data(:,2),'normal','link','identity');
b5 = regress(data(:,2),X);