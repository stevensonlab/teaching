
%% 3.1 Load the data and preview...

load('data_v1_binned_moving.mat')

dataset_number = 1;
neuron_number = 1;

S = data{dataset_number}.spikes(neuron_number,:,:,:);
S = squeeze(S); % make data cube from the original 4d data (only look at 1 neuron for now)

figure(1)
imagesc(mean(S,3)); % show the average spike response over time
xlabel('Time'); ylabel('Direction')

% Sum spike counts over time so that we have a single tuning function
spike_counts = sum(S(:,25:80,:),2);   % only take the data from time bins 25-80
spike_counts = squeeze(spike_counts); % make data cube into a matrix [direction x trials]


%% 3.2 Plot spike counts as a function of direction

figure(2)
stim_direction = linspace(0,2*pi-2*pi/16,16);
plot(stim_direction,spike_counts,'ko')
xlabel('Direction [rad]'); ylabel('Spike Count')

%% 3.3 Make a function vonMises.m and Plot it using the following...

figure(3)
x = linspace(0,2*pi,256);  % Directions to plot a smooth curve
b = [1 .5 pi];              % arbitrary parameters to test things out
plot(x,vonMises(b,x))
xlabel('Direction [rad]'); ylabel('Von Mises')

%% 3.4 Use fminsearch to find the parameters (b) that minimize the sum squared error

x_matrix = repmat(stim_direction',1,13); % first we need to make sure 'x' and 'y' are the right sizes and lined up
options=[]; % for now just use default options (see help fminsearch for more)
b_mse = fminsearch('vonMisesCost',[1 0.1 pi],options,x_matrix(:),spike_counts(:)); % do the optimization

%% 3.5 Plot your model fit with the data


figure(4)
scatter(x_matrix(:)*180/pi,spike_counts(:),spike_counts(:)*0+60,'filled','MarkerFaceAlpha',0.4)     % plot the data
hold on
x0 = linspace(-10,345,256)*pi/180;
plot(x0*180/pi,vonMises(b_mse,x0),'LineWidth',2) % plot the prediction
hold off
xlim([min(x0) max(x0)]*180/pi)
box off; set(gca,'TickDir','out')
ylabel('Spike Rate')
xlabel('Stimulus Direction [deg]')


%%


f = @(b,x) exp(b(1)+b(2)*cos(2*(x-b(3))));
b_mse = nlinfit(x_matrix(:),spike_counts(:),f,[1 0.1 pi]);
