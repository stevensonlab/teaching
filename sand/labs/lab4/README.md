# Lab 4

This lab is designed to introduce you to frequency analysis. The goal is to complete a script that will show the amplitude spectrum and spectrogram for an EEG signal.

Start by downloading the matlab scripts (.m files) and data (.mat files).

chb_sample.mat comes from Children's Hospital Boston, and consists of [EEG recordings](https://physionet.org/content/chbmit/1.0.0/) from pediatric subjects with intractable seizures.


## Goal

![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab4/assets/output.png)

## Part 1: Getting familiar with the data

The first section of the `lab4.m` script loads the data and sets up the relevant variables. Complete the script to plot the time series with an accurate time axis. The `data` variable is a cell array with 23 entries for 23 (bipolar) measurements. Note: The sampling frequency of these signals is 256Hz.

## Part 2: Compute and Plot the Fourier Transform of one channel

Complete the following code to show the amplitude spectrum of one channel of the EEG.

	% NFFT = ???;
	Y = fft(y,NFFT);
	f = Fs/2*linspace(0,1,NFFT/2); % get frequency axis from zero up to Nyquist limit

	% Plot single-sided amplitude spectrum.
	figure(2)
	% plot(???)
	ylabel('Amplitude')
	xlabel('Frequency [Hz]')

Note: The fft (Fast Fourier Transform) is often considered a noisy estimate of the true underlying power/amplitude spectrum. To create a smoother estimate, many labs prefer to use Welch's method (`pwelch`) of a Multi-tapered spectrum (`pmtm`). Try these methods in place of `fft` if you have time.

## Part 3: Compute and Plot the Spectrogram

In many neuroscientific settings, it is helpful to examine how the power spectrum varies over time. Here we will examine the spectrogram using a Short-Time Fourier Transform (STFT). Complete the code below 

	figure(3)
	% [S,f,t] = spectrogram(???);
	% imagesc(???)
	axis xy
	xlabel('Time [s]'); ylabel('Frequency [Hz]')

Using `doc` may be helpful to understand the inputs and outputs of the spectrogram function.

## Part 4: Compare Wide- and Narrow-band Spectrograms

One of the central ideas in frequency analysis is the uncertainty principle. Vary the window size of your `spectrogram` to explore how this alters your STFT.

## Python examples

Tutorial Version:
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1H6Qodzdq8ZoP1DhZTPUKUCHB22YtkZkE?usp=sharing)

Solution:
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1XjB2jLXsGX-bRgZ8Oo0Ukhu78YASOjps?usp=sharing)



	import scipy.io
	import numpy as np
	import matplotlib.pyplot as plt

	mat = scipy.io.loadmat('chb_sample.mat')
	data = mat.get('data')[0]

	plt.plot(data[0])
