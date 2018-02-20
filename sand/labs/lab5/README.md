# Lab 5

This lab is designed to introduce you to frequency analysis. The goal is to complete a script that will filter a local field potential (LFP) signal, explore the effects of different filtering options, and to try a wavelet transform.

Start by downloading the matlab scripts (.m files) and data (.mat files).

ec014_639_samp.mat comes from a large dataset of [hippocampal recordings from Gyuri Buzsaki's lab](http://crcns.org/data-sets/hc/hc-3), and consists of local field potentials (LFP) and spikes recorded from the dorsal hippocampus of a rat traversing a linear maze (along with position information).


## Goal

![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab5/assets/output.png)

## Part 1: Compute and Plot the Fourier Transform of one channel

The sampling rate of the signal is 256Hz.

Note: The fft (Fast Fourier Transform) is often considered a noisy estimate of the true underlying power/amplitude spectrum. To create a smoother estimate, many labs prefer to use Welch's method (`pwelch`) of a Multi-tapered spectrum (`pmtm`). Try these methods in place of `fft` if you have time.

## Part 2: Filter the data and compare the filtered signal to the original

## Part 3: Compute a wavelet spectrogram

## Part 4: Align and compare your spectrogram to the behavioral information

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