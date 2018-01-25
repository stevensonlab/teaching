# Lab 1

This lab is designed to introduce you to programming with matlab and working with neural data. The goal is to write a set of scripts/functions that will plot a spike raster and peri-stimulus time histogram for spikes responses to multiple trials of a repeated stimulus.

Start by downloading the matlab scripts (.m files) and data (.mat file).

The data here comes from [Britten et al. 1992](http://www.neuralsignal.org/data/09/nsa2009.1.html) and was analyzed in Bair and Koch, 1996. This data illustrates the, somewhat surprising, finding that neurons in MT respond to, not just the direction but also, the detailed structure of random dot stimuli.


## Goal

![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab1/assets/output.png)

## Part 1: Plot a single trial spike train

After loading the data, try entering the following commands

	>> data(1)

	ans = 

	            name: 'e053c'
        	    desc: {1x6 cell}
    	trial_params: [30x3 double]
    	        spks: {1x30 cell}

	>> data(1).spks{1}

The array produced by `data(1).spks{1}` represents the spike times of neuron 1 on trial 1. Use the `plot` function to plot these spikes.

## Part 2: Plot multiple trials

Complete the loop started in `plotSpikeRaster.m` to generate a spike raster (top panel of the output).

## Part 3: Make a function to draw the raster for any neuron

Now make `plotSpikeRaster.m` into a `function` that plots the raster for whatever data is input to it.

## Part 4: Calculate the PSTH

Complete the script started in `getPSTH.m` so that the variable `psth` contains the total number of spikes (across trials) that occurred a given time after the stimulus.

## Part 5: Make a function to calculate the PSTH for any neuron

Now make `getPSTH.m` into a `function` that takes a input and returns the PSTH variable

## Part 6: Make a script to plot the final output

Using the functions `getPSTH.m` and `plotSpikeRaster.m` complete the script started in `lab1.m` so that when you run it it generates the desired plot with the raster and psth aligned.