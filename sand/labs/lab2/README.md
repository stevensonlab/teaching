# Lab 2

This lab is designed to introduce you to polynomial regression and boostrapping. The goal is to write a script that will fit a linear trend and to find standard errors for the parameter estimates using bootstrapping.

Start by downloading the matlab scripts (.m files) and data (.csv files).

There are two data files here. BodyBrain.csv comes from Weisberg, Applied Linear Regression, and illustrates the linear relationship between log-body weight and log-brain weight for mammals. Hursh1936.csv illustrates the linear relationship between fiber diameter and conduction velocity in myelinated axons.

## Goal

![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab2/assets/output_bodybrain.png)
![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab2/assets/output_hursh.png)

## Part 1: Getting familiar with the `bootstrp` function

After loading the data, try completing the following code to find the bootstrap distribution for the mean of your x-variable.

	nboot = 10000;
	bootstat = bootstrp(nboot,'mean',???);

Make a histrogram of this distribution using `histogram`. Do the mean and standard deviation of this distribution match what you expect?

## Part 2: Plot the data

Use the `plot`  function to generate a scatter plot of your x and y variables.

## Part 3: Linear (and polynomial) Regression

Try completing the following code to fit a linear model to your data

	b = polyfit(???);

Looking at the `doc` for `polyfit` may be helpful.

## Part 4: Plot your regression function along with the data

The `polyval` function takes x values and parameters as input and returns estimated y values.

## Part 5: Use bootstrapping to find standard errors for your parameter estimates

Complete the following code to find bootstrap distributions for the parameters of your regression.

	nboot = 1000;
	for i=1:nboot
    		sample_indices = randsample(n,n,true);
    		bboot(i,:) = polyfit(???);
	end

By using each of these samples in `polyval` you can find standard errors for your predictions of y.

## Bonus

Compare your bootstrap standard errors to those output by `regress` or `glmfit`.

## Python Examples

Tutorial Version:
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1B21Voux2x-YD6aDLy8pezJidywyPDVff?usp=sharing)

Solution:
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1CgeLdCwQoAuH-usI-E0Ea4UmUIax1_x4?usp=sharing)
