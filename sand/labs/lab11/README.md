# Lab 11

This lab is designed to introduce you to some of the basic processing involved in analyzing Calcium imaging. The goal is to complete a script with some basic visualization, motion artifact correct, ROI extraction, and deconvolution.

Start by downloading the code (.m file) and data ([download here](https://uconn-my.sharepoint.com/:u:/g/personal/ian_stevenson_uconn_edu/Ec77KGIfUQBEoUWlC-PdQSsBU4Hc5y9ECmdx_T-R6KnUZg?e=78BKAl)). This data contains a short segment of a two-photon recording from mouse primary visual cortex using GCaMP6s taken from [CRCNS pvc-7](https://crcns.org/data-sets/vc/pvc-7/about-pvc-7).

## Goal

![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab11/assets/output.png)

![alt text](https://github.com/stevensonlab/teaching/raw/master/sand/labs/lab11/assets/output2.png)

## Part 1: Visualization

Use `imagesc` to show a frame of the movie alongside the average over all time. You can experiment with different colormaps using `colormap gray` or `colormap turbo`.

Since this is spatiotemporal (e.g. video) data it is often helpful to visualize as a movie. Complete the `for` loop to geneterate this. Note that there are some noticeable motion artifacts.

## Part 2: Estimating and correcting for motion artifacts

There are many methods for correcting for motion artifacts. The first section in Part 2 shows a basic comparison of two sequential frames in the movie.

To track the difference between the frames one strategy is to use the 2D cross-correlation (`xcorr2`). There are also some basic registration methods built into matlab's image processing toolbox. `imregtform` estimates a transformation between the successive frames. Try completing the code for `imwarp` that uses the ouput of `imregtform` to "register" `frame2` with `frame1`.

## Part 3: ROI extraction

Regions of interest (ROIs) can also be identified using several different techniques. When cells overlap it can be beneficial to excliticly separate parts of the video into spatial (ROIs) and temporal fluorescence patterns. After running `pca`, try visualizing these patterns. Note that the spatial patterns are represented by the PCs themselves `C` and the temporal patterns are represented by the scores `S`.


## Part 4: Deconvolution

In some cases, researchers aim to remove the slow effects due to the timecourse of fluorescence and estimate underlying neural activity. Download the code for `fast_oopsi.m` (slightly modified from [Josh Vogelstein](https://github.com/jovo/oopsi)). Trying running this section as is. Then try modifying the time constant for the fluorescence `tau`, and explore how things change for different ROIs.
