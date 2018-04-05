
%% Plot the signals...

figure(1)
subplot(2,2,1)
% plot(???)
title('Current Dendrite')
subplot(2,2,3)
% plot(???)
title('Current Soma')
subplot(2,2,2)
% plot(???)
title('Voltage Dendrite')
subplot(2,2,4)
% plot(???)
title('Voltage Soma')


%% Calculate entropy...

y = voltage_soma(:,1);
x = linspace(min(y),max(y),100);  % histogram bin edges
n = histc(y,x);
p = n/sum(n);   % normalize to get probability distribution

figure(2)
bar(x,p)
xlabel('Voltage')
ylabel('Probability')

%% Entropy

% ???


%% Mutual Information uses the joint distribution and product of marginals...

% Joint Distribution...
x1   = voltage_dend(:,1);
x1rg = linspace(min(x1),max(x1),100);
x2   = voltage_soma(:,1);
x2rg = linspace(min(x2),max(x2),100);
% [ym,yb,ns] = bindata2(???);
% pxy = ???;    % normalize to make it a probability

figure(3)
subplot(1,2,1)
% imagesc(???)
xlabel('Voltage Soma')
ylabel('Voltage Dendrite')
title('Joint Distribution')

% Product of marginals...
p1 = sum(ns,2)/sum(ns(:)); % normalized marginal of x1
p2 = sum(ns,1)/sum(ns(:)); % normalized marginal of x2
% pxy_independent = ???;

subplot(1,2,2)
% imagesc(???)
xlabel('Voltage Soma')
ylabel('Voltage Dendrite')
title('Product of Marginals')


% Mutual information calculation...
% ???

%% Function to automate the previous section...

% mi = getMI(???);

%% Calculate MI at various lags for various signals

for deltat = -100:100
%     mit(deltat+101)= getMI(circshift(???),???);
end
    
figure(4)
% plot(???)
xlabel('Lag')
ylabel('Mutual Information [bits]')