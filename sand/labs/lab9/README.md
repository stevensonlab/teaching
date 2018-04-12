# Lab 9

This lab is designed to introduce you to Bayes Rule and Naive Bayes classification. The goal is to complete a script that will classify neural responses to decode a behavior. Unlike Lab 6, which used a discriminative classifier (logistic regression), here we will use a generative classifier (naive Bayes).

Start by downloading the code (.m file) and data (.mat file).

millerLab_2reach_sample.mat comes from a subset of [data from the Miller Lab](http://crcns.org/data-sets/movements/dream), and contains spike counts from 35 neurons in primary motor cortex (M1) as a monkey was making center-out reaches. For simplicity we have only included data from the 205 trials where the monkey was either reaching left or right.

## Goal

![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab9/assets/output.png)

## Part 1: Fitting the likelihoods

After loading the data there should be two variables: `X` and `y`. `X` contains the spike counts from 205 trials and 35 neurons, and each trial was either to the left (y=1) or right (y=0).

In order to use Bayesian decoding, we first need to write down a description of the likelihood. In this case, that means finding p(spikes|L) and p(spikes|R). Start by picking one neuron and plotting the histogram of its spike counts for all of the trials to the left and the histogram for all of the trials to the right.

Now let's "fit" these histograms with Poisson distributions. Recall that the best fit Poisson distribution (the MLE) is just the one where the mean of a Poisson distribution is the sample mean. Add these model distributions to your plot. Do they provide a reasonable fit?


## Part 2: Bayes Rule for a single neuron

Given the likelihoods from Part 1, in order to decode, we now need to use Baye's rule to find p(L|spk). Add a calculation to your script that finds p(L|spk) assuming p(L)=p(R)=0.5 to your script, and add this probability to your histogram plot for different possible values of spk.

## Part 3: Finding the population posterior using Naive Bayes

To combine evidence across neurons, here we will make the naive Bayes assumption that the neurons are conditionally independent given the trial-type.

Complete the loop calculating the posterior for each neuron on each trial. Then after the loop multiply the probabilities and renormalize to calculate the population posterior. Each trial should now have a posterior probability indicating the probability that that trial was to the left, given the spiking of all observed neurons.

Try plotting these population probabilities and/or the posterior probability from each neuron. Are some neurons more informative than others?

## Part 4 (optional): Comparison to logistic regression

Discriminative and generative classifiers are conceptually different. In this last section, try using the `glmfit` and `glmval` methods from Lab 6 and matlab's native naive Bayes methods `fitcnb` and `predict` to compare these two approaches on random subsets of neurons. Which model is more accurate? When might the other model be preferrable?

## Minimal python example

	import scipy.io
	import numpy as np
	import matplotlib.pyplot as plt

	mat = scipy.io.loadmat('millerLab_2reach_sample.mat')
	X = mat.get('X')
	y = mat.get('y')

	plt.plot(X[:,0]) # spike counts from neuron 1 (all trials)
	plt.plot(X[y[:,0]!=0,0]) # spike counts from neuron 1 (left trials)
	plt.plot(X[y[:,0]==0,0]) # spike counts from neuron 1 (right trials)
