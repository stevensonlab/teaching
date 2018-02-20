# Lab 5

This lab is designed to introduce you to frequency analysis. The goal is to complete a script that will filter a local field potential (LFP) signal, explore the effects of different filtering options, and to try a wavelet transform.

Start by downloading the matlab scripts (.m files) and data (.mat files).

ec014_639_samp.mat comes from a large dataset of [hippocampal recordings from Gyuri Buzsaki's lab](http://crcns.org/data-sets/hc/hc-3), and consists of local field potentials (LFP) and spikes recorded from the dorsal hippocampus of a rat traversing a linear maze (along with position information).


## Goal

![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab5/assets/output.png)

## Part 1: Compute and Plot the Fourier Transform of one channel

Using what you learned in Lab 4, calculate and plot the amplitude spectrum for one channel of the LFP data. The sampling rate of the signal is 256Hz.

## Part 2: Filter the data and compare the filtered signal to the original

The specific filter design is up to you. To give you some ideas -- In practice, filtering is often used to smooth/denoise a signal (using a low-pass filter), extract a specific frequency range such as the theta-band (using a band-pass filter), remove specific types of noise or artifacts such as 60Hz noise (using a notch filter), or remove slow drift in a signal (using a high-pass filter).

Matlab has a wide variety of functions for filter design. Some commonly used ones include Butterworth filters (`butter`), Chebyshev (`cheby1`), and Elliptical (`ellip`) filters. `designfilt` allows even more flexible filter specification.


Note: Standard filtering (e.g. using `filter`) results in a phase-shifted signal. In Matlab you can zero-phase filter using the `filtfilt` function, which filters the signal in both the forward and reverse directions. Or you can correct for the mean group delay by shifting the signal (see `grpdelay`).

## Part 3: Compute a wavelet spectrogram

Use the `cwt` function (requires the wavelet toolbox in matlab) to calcualte a wavelet transform. If you have time, compare the wavelet spectrogram to the standard spectrogram.

## Part 4: Align and compare your spectrogram to the behavioral information

A common finding in hippocampal research is that the hippocampal LFP amplitude in the theta band (~8-12Hz in rats) is correlated with an animal's speed. Does this relationship exist in this data?

## Minimal python example

	import scipy.io
	import numpy as np
	import matplotlib.pyplot as plt
	
	mat = scipy.io.loadmat('ec014_639_samp.mat')
	
	lfp = mat.get('lfp')
	pos = mat.get('pos')
	Tlist = mat.get('Tlist')
	# Tlist[0][2].flatten() # spike times for neuron 3
	
	plt.plot(lfp[0:256*10,1])