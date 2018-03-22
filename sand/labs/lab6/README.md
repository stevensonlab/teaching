# Lab 6

This lab is designed to introduce you to generalized linear models and neural coding. The goal is to complete a script that will decode the orientation of a visual stimulus using the activity of a population of neurons recorded from V1.

Start by downloading the data (.mat file).

data_v1_binned_static.mat comes from [Ecker et al. (2010) and Berens et al. (2012)](http://bethgelab.org/datasets/v1gratings/).

## Goal

![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab6/assets/output.png)

## Part 1: Getting familiar with the data and setting up the problem

As in Lab 3, the data is organized as a 4D matrix [neurons x stimulus_conditions x time x repeated_trials]. Our goal is to take the activity of all neurons (summed over some time range) and discriminate the trials for two specific conditions. We will need a [trials x neurons] matrix `X` that contains the neural activity as well as a [trials] vector `y` that contains the condition identity (0 or 1).

Dataset #8, for instance contains static grating stimuli for 7 directions and 2 contrasts (10 and 100%). Try generating `X` and `y` to compare the 0 and 90 degree stimuli at 100% contrast. Use `imagesc` to visualize `X`. Do you think the classifier should be able to distinguish between the conditions?

## Part 2: Logistic regression

Use `glmfit` with the `binomial` option to to fit logistic regression using the matrix `X` and vector `y`. Then use `glmval` to get predictions for each `X`.

## Part 3: Calculate the prediction accuracy

Compare your model predictions with the data, and measure the overall accuracy.

## Part 4: Find the accuracy as a function of time

Write a loop over time, fitting logistic regression for each time bin and storing the accuracy. Plot the accuracy as a function of time since stimulus onset.

## Minimal python example

	import scipy.io
	import numpy as np
	import matplotlib.pyplot as plt

	mat = scipy.io.loadmat('data_v1_binned_static.mat')
	data = mat.get('data')[0][0]

	conditions = data['conditions'][0][0]
	spike_count = data['spikes'][0][0]

	neuron=0
	plt.plot(np.sum(spike_count[neuron,:,24:79,:],axis=1))