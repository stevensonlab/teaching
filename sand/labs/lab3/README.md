# Lab 3

This lab is designed to introduce you to nonlinear regression. The goal is to complete a script that will optimize a set of parameters for a nonlinear function that describes the direction tuning of neuron recorded from V1.

Start by downloading the matlab scripts (.m files) and data (.mat files).

data_v1_binned_moving.mat comes from [Ecker et al. (2010) and Berens et al. (2012)](http://bethgelab.org/datasets/v1gratings/).

## Goal

![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab3/assets/output.png)

## Part 1: Getting familiar with the data

The first section of the `lab3.m` script loads the data and makes an image plot of the activity of one of the recorded neurons from one experiment.

	S = data{dataset_number}.spikes(neuron_number,:,:,:);
	S = squeeze(S); % make data cube from the original 4d data (only look at 1 neuron for now)

	figure(1)
	imagesc(mean(S,3)); % show the average spike response over time
	xlabel('Time'); ylabel('Direction')

	% Sum spike counts over time so that we have a single tuning function
	spike_counts = sum(S(:,25:80,:),2);   % only take the data from time bins 25-80
	spike_counts = squeeze(spike_counts); % make data cube into a matrix [directions x trials]

The data is organized as a 4D matrix [neurons x stimulus_directions x time x repeated_trials]. After running this section, what does the `spike_counts` variable represent?

## Part 2: Plot the data

Complete the following code to show the spike counts on each trial as a function of the stimulus direction.

	figure(2)
	stim_direction = linspace(0,2*pi-2*pi/16,16);
	% plot(?)

## Part 3: Make a function for a von Mises tuning curve

Here we will use a von Mises function to describe the direction tuning of our neuron. Make your function `vonmises.m` so that it takes two inputs: the parameters and the direction(s) where you want to evaluate the function and returns the function value. Once done, you should be able to run the following section to generate a plot of your function

	figure(3)
	x = linspace(0,2*pi,256);  % Directions to plot a smooth curve
	b = [1 .5 pi];              % arbitrary parameters to test things out
	plot(x,vonMises(b,x))
	xlabel('Direction [rad]'); ylabel('Von Mises')


## Part 4: Minimize the error of your parameter values

Matlab has built-in functions to do the optimization, but they require an error function as input. Make a function named `vonmisesCost.m`

	x_matrix = repmat(stim_direction',1,13); % first we need to make sure 'x' and 'y' are 	the right sizes and lined up
	options=[]; % for now just use default options (see help fminsearch for more)
	b_mse = fminsearch('vonmisesCost',[1 0.1 pi],options,x_matrix(:),spike_counts(:)); % do the optimization

## Part 5: Plot your model fit alongside the data

## Python examples

Tutorial Version:
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1XF5FxbAAPTG1-1IF9PGigMA_s5X-Zv8y?usp=sharing)

Solution:
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1_C_Mezz1ROwunWHBSj-RNnyCXPDSygTq?usp=sharing)


	import scipy.io
	import numpy as np
	import matplotlib.pyplot as plt

	mat = scipy.io.loadmat('data_v1_binned_moving.mat')
	data = mat.get('data')[0][0]

	conditions = data['conditions'][0][0]
	spike_count = data['spikes'][0][0]

	neuron=0
	plt.plot(np.sum(spike_count[neuron,:,24:79,:],axis=1))
