
%% 3.1 Load the data and preview...

load('data_v1_binned_moving.mat')

dataset_number = 1;
neuron_number = 1;

S = data{dataset_number}.spikes(neuron_number,:,:,:);
S = squeeze(S); % make data cube from the original 4d data (only look at 1 neuron for now)

figure(1)
imagesc(mean(S,3)); % show the average spike response over time
xlabel('Time'); ylabel('Orientation')

% Sum spike counts over time so that we have a single tuning function
spike_counts = sum(S(:,25:80,:),2);   % only take the data from time bins 25-80
spike_counts = squeeze(spike_counts); % make data cube into a matrix [orientations x trials]


%% 3.2 Plot spike counts as a function of orientation

figure(2)
stim_orientation = linspace(0,2*pi-2*pi/16,16);
% plot(?)

%% 3.3 Make a function vonMises.m and Plot it using the following...

figure(3)
x = linspace(0,2*pi,256);  % Orientations to plot a smooth curve
b = [1 .5 pi];              % arbitrary parameters to test things out
plot(x,vonMises(b,x))
xlabel('Orientation [rad]'); ylabel('Von Mises')

%% 3.4 Use fminsearch to find the parameters (b) that minimize the sum squared error

x_matrix = repmat(stim_orientation',1,13); % first we need to make sure 'x' and 'y' are the right sizes and lined up
options=[]; % for now just use default options (see help fminsearch for more)
b_mse = fminsearch('vonmisesCost',[1 0.1 pi],options,x_matrix(:),spike_counts(:)); % do the optimization

%% 3.5 Plot your model fit with the data

