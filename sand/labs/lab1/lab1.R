# install.packages("R.matlab")
library(R.matlab)
data <- readMat('nsa2009_1.mat')

###############

neuron<-33
data$data[,,neuron]$name

# Plot the spike raster
???

# Plot the PSTH
barplot(???)


##################
 
plotSpikeRaster <- function(spikeList) {
	plot(???)
	for (trial in 2:length(spikeList)) {
		points(???)
	}
}
 
##################

getPSTH <- function(spikeList,binsize=5) {
	maxTime = 2000     # in ms
	psth = ???
	for (trial in 1:length(spikeList)) {
    	time_index =1
    	for (t in seq(0,maxTime,by=binsize)) {
        	psth[time_index] = ???
	        time_index = time_index+1
    	}
	}
	psth
}