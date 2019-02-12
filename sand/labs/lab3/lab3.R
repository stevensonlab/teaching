
# 3.1 Load the data and preview...

library(R.matlab)
library(R.utils)
data <- readMat('data_v1_binned_moving.mat')

dataset_number = 1
neuron_number = 1

stimulus_conditions = data$data[[dataset_number]][[1]][[3]]

# conditions x time x trials
spikes = data$data[[1]][[1]][[6]][neuron_number,,,]


# visualize neuron's response to different orientations
image(t(rowMeans(spikes,dims=2)),xlab='Time',ylab='Orientation')


# sum spike counts over time so that we have a single tuning function, only take the data from time bins 25-80
spike_counts = colSums(wrap(spikes[,25:80,],map=list(2,1,3)))


# 3.2 Plot spike counts as a function of orientation

stim_orientation = seq(0.0,2*pi-2*pi/16,length=16)
X = kronecker(matrix(1,1,13),stim_orientation)
plot(???)


# 3.3 Make a function vonMises.m and Plot it using the following...

vonMises<-function(b,x) {
  # von mises
  ???
}

x = seq(0,2*pi,length=256) # Orientations to plot a smooth curve
b = c(1,.5, pi)          # arbitrary parameters to test things out
plot(x,vonMises(b,x),xlab='Orientation [rad]',ylab='Von Mises')



# 3.4 Use fminsearch to find the parameters (b) that minimize the sum squared error

vonMisesCost<-function(b,x,y) {
  ???
}

b_mse <- optim(c(1,0.1,pi),vonMisesCost,method='Nelder-Mead',x=X,y=spike_counts)



# 3.5 Plot your model fit with the data

???
