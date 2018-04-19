# Lab 10

This lab is designed to introduce you to the leaky-integrate-and-fire model neuron. The goal is to complete a script that will simulate the spiking of this neuron and do some basic exploration of the model.

Start by downloading the code (.m file).

## Goal

![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab10/assets/output.png)

## Part 1: Getting the simulation up and running

Start by setting some initial parameter values for the LIF model...

tau=10ms, R=10MOhm, E_L=-65mV, V_reset=-65mV, V_threshold=-50mV

Create a time varying current I (e.g. a step current). Then run the simultaion loop that is already completed (it assumes 1ms step size). Is the resulting voltage what you expected? What happens when you change the parameters?

## Part 2: Finding the rheobase

Vary the amplitude of the current and find the minimum current that causes the neuron to spike (the rheobase). For the LIF neuron, you can find the rheobase analytically by finding the steady-state solution when V=V_thresh. Try deriving this steady-state - are the numbers consistent?

## Part 3: Computing the coefficient of variation for the interspike intervals

An important measure of spike regularity is the coefficient of variation (CV) - the standard deviation of the inter-spike intervals divided by the mean. What is the CV for the LIF model with constant current input?

## Part 4: Noise-driven LIF model

Now, instead of using constant current input, use `randn` to create white-noise current. How does the CV change when the standard deviation of your current is fixed but the mean current changes? Try using 1nA for the SD.

## Bonus 1: Coupled LIF neurons

Try modifying the loop so that two LIF neurons are coupled together. You can implement synaptic currents using delta functions (in the `if` statement) or using another state variable. By varying the synaptic strength you should be able to synchronize the firing of the two neurons.

## Bonus 2: Large network

The `izhikevich_network.m` script contains a simple simulation of one thousand [Izhikevich neurons](https://www.izhikevich.org/publications/spikes.htm). The initial settings are with 80% excitatory neurons and 20% inhibitory neurons, randomly connected. What happens when you change the average connection strength(s)?

## Minimal python example

	import scipy.io
	import numpy as np
	import matplotlib.pyplot as plt
	
	tau = 10;    # membrane time constant (ms)
	R   = 10;    # membrane resistance (MOhms)
	E_L = -65;    # resting potential for the leak (mV)
	Vthresh= -50;   # spike threshold (mV)
	Vreset = -65;   # reset potential (mV)
	
	T = 1000; # simulation time (ms)
	
	I = np.zeros(T);
	I[200:800] = 1.52;
	
	V = np.zeros(T);
	V[0] = -64.5;   # initial membrane potential (mV)
	for t in np.arange(T-1)+1:     # ms timesteps
    	# Integrate...
    	V[t] = V[t-1] + (I[t]*R - (V[t-1]-E_L))/tau;
    
    	# Fire...
	    if V[t]>Vthresh:
	        V[t] = Vreset;

	plt.plot(V+(V==Vreset)*65)
	plt.plot(I)

There is a much more extenstive example [here](https://neuronaldynamics-exercises.readthedocs.io/en/latest/exercises/leaky-integrate-and-fire.html)