# Lab 7

This lab is designed to introduce you to two concepts in unsupervised learning: dimensionality reduction and clustering. The goal is to complete a script that will replicate a (simplified) spike sorting pipeline using spike waveforms from a polytrode recording in rat hippocampus.

Start by downloading the code (.m file) and data (.mat file).

ec014_333_spksort_samp.mat comes from the Buzsaki Lab and [Mizuseki et al. (2009)](http://crcns.org/data-sets/hc/hc-3/about-hc-3). This is a *small* segment of the available data that contains waveforms from 1 animal and 1 shank of a multielectrode array recording.

## Goal

![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab7/assets/output.png)

## Part 1: Getting familiar with the data and setting up the problem



## Part 2: Principal Components Analysis



## Part 3: k-Means Clustering



## Part 4: Choosing k



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