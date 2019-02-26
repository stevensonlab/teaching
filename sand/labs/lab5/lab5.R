
## 5.1 Plot single-sided amplitude spectrum

#install.packages('Rwave')
library(R.matlab)
library(signal)
library(Rwave)
data <- readMat('ec014_639_samp.mat')
lfp = data$lfp[,1]


Fs <- 256                     # Sampling frequency
T <- 1/Fs                     # Sample time
L <- length(lfp)
t <- seq(0,L*T,length.out=L)  # Time vector

# use code from Lab 4
plot(t[1:1000],lfp[1:1000],type='l',main='LFP',xlab='Time [s]')

NFFT <- 1024
f <- seq(0,1,length.out=NFFT)
Y <- spectrum(lfp,log='no',span=100,plot=FALSE)
f <- Y$freq/T
plot(f,log(2*Y$spec),type='l', ylab='Amplitude',xlab='Frequency [Hz]')



## 5.2 Filter the data and compare to original


f_lo <- 4
f_hi <- 12
filter <- cheby1(6,2,c(f_lo,f_hi)/(Fs/2),type="pass")

# filtered signal
sig2 <- signal::filter(filter, x=lfp)
sig3 <- signal::filtfilt(filter, x=lfp)
plot(t[1:1000],lfp[1:1000],type='l',main='LFP',xlab='Time [s]')
lines(t[1:1000],sig2[1:1000],col='red')
lines(t[1:1000],sig3[1:1000],col='blue')


# some more options...
# filter <- butter(???)
# filter <- cheby1(???)
# filter <- fir1(???)
# filter <- remez(???)


# Plot the original and filtered spectrum...
## TODO
  
# Examine the filter properties
plot(filter$b,type='l')

freqz(filter)
d<-grpdelay(filter)
plot(d)


## 5.3 Wavelet Transform...

df<- data.frame(x=data$lfp[1,10000,1])
w <- analyze.wavelet(df, "x", loess.span = 0, dt = T, dj = 1/20, make.pval = FALSE)

c<-cwt(lfp[1:10000],10,nvoice=10,plot=TRUE)


## 5.4 Plot the position alongside the cwt...

# plot(data$pos[1:100000],type='l')
