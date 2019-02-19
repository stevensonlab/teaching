# install.packages('signal')

### 4.1 Plot time series

library(R.matlab)
library(signal)
data <- readMat('chb_sample.mat')

y <- data$data[[19]][[1]]

Fs <- 256                     # Sampling frequency
T <- 1/Fs                     # Sample time
L <- length(y)                # Length of signal
t <- seq(0,L*T,length.out=L)  # Time vector

# Plot signal...
plot(t,y,type='l',main='EEG',xlab='Time [s]')




## 4.2 Compute and plot Fourier Transform

NFFT <- 1024
f <- seq(0,1,length.out=NFFT)
Y <- spectrum(y,log='no',span=100,plot=FALSE)
f <- Y$freq/T

# Plot single-sided amplitude spectrum.
plot(f,2*Y$spec,type='l', ylab='Amplitude',xlab='Frequency [Hz]')



## 4.3 Compute and plot a Spectrogram

Y <- specgram(y,n=NFFT,Fs=Fs)
# specgram(y,n=NFFT,Fs=Fs) # to show image



## 4.4 Compare Wide vs Narrow-band Spectrograms...






