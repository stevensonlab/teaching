# Lab 8

This lab is designed to introduce you to two concepts in information theory: entropy and mutual information. The goal is to complete a script that will calculate the entropy of and mutual information between voltage signals recorded intracellularly and simultaneously from the dendites and soma of a pyramidal neuron.

Start by downloading the code (.m file) and data (.mat file).

epfl_challengeC_samp.mat comes from the [EPFL single neuron prediction challenge](http://icwww.epfl.ch/~gerstner/QuantNeuronMod2007/challenge.html), and was recorded in the Luscher Lab [Larkum et al. (2004)](https://academic.oup.com/cercor/article/14/10/1059/275677).

## Goal

![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab8/assets/output.png)

## Part 1: Getting familiar with the data

After loading the data there should be four variables: `current_dend`, `current_soma`, `voltage_dend`, and `voltage_soma`.  The voltage variables were recorded with 14 trials. During the first 7 trials current was injected only in the soma, and in the last 7 trials current was injected in both the soma and the dendrites. Note that the `current_*` variables only have two conditions (one for the first 7 trials and one for the last 7).

Start by plotting each of the variables for trial 1 and trial 8.

## Part 2: Calculating Entropy

Using `histc`, make a bar chart for the probability mass function of one of the voltage signals (again only 1 trial). Calculate the entropy of this distribution in bits. Note: Be careful to avoid bins that have 0 probabilitiy in your calculation, since `log(0)=-Inf`.

## Part 3: Calculating Mutual Information

Next we will calculate the mutual information between two variables.

Use `bindata2` to create a two-dimensional probability mass function for the joint distribution of the dendritic voltage and the somatic voltage (for 1 trial). Use `imagesc` to visualize the distribution. This will be the numerator of the mutual information calculation. Compare this plot to the product of the marginal distributions (the denominator of the mutual information calculation). Finally, calculate the mutual information between your two variables in bits.

For flexibility, copy this code and make a function `getMI` that can take any two inputs and returns the mutual information in bits.

## Part 4: Integration of dendritic and somatic currents

Now let's use these tools to understand the experimental data. Write a loop that calculates the mutual information between different signals at varying time lags (hint: use circshift). Plot the mutual information as a function of the lag. Does the location of the peak make sense? How do the first 7 trials compare to the last 7 trials?


## Minimal python example

	import scipy.io
	import numpy as np
	import matplotlib.pyplot as plt

	mat = scipy.io.loadmat('epfl_challengeC_samp.mat')
	voltage_dend = mat.get('voltage_dend')
	voltage_soma = mat.get('voltage_soma')
	current_dend = mat.get('current_dend')
	current_soma = mat.get('current_soma')

	plt.plot(voltage_soma[:,0]) # plot the somatic voltage for trial 1
	plt.plot(voltage_dend[:,0]) # plot the dendritic voltage for trial 1

	# for the joint distribution you can use something like...
	# H, xedges, yedges = np.histogram2d(voltage_soma[:,0], voltage_dend[:,0],100)
