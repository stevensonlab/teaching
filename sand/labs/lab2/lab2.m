

%% 2.0 Load data...

% either Axon Diameter vs Conduction Velocity
data = readtable('Hursh1936.csv');

% or log-Body Weight vs log-Brain Weight
data = readtable('BodyBrain.csv');

data = table2array(data);
x = data(:,1);
y = data(:,2);
n = size(data,1);

%% 2.1 Bootstrap to estimate the mean and sem of the x-variable

nboot = 10000;
bootstat = bootstrp(nboot,'mean',???);
histogram(???)

%% 2.2 Plot the data


%% 2.3 Linear regression

% linear regression
b = polyfit(???);

%% 2.4 Plot the data and fit


%% 2.5 Bootstrap to find error-bars for the model parameters

nboot = 1000;
for i=1:nboot
    sample_indices = randsample(n,n,true);
    bboot(i,:) = polyfit(???);
end




