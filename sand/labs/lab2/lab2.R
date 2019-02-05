

### 2.0 Load data...

# either Axon Diameter vs Conduction Velocity
data <- read.csv(file='Hursh1936.csv',header=FALSE);

# or log-Body Weight vs log-Brain Weight
#data <- read.csv('BodyBrain.csv',header=TRUE);


### 2.1 Bootstrap to estimate the mean and sem of the x-variable

library(boot)

nboot = 10000
mfun <- function(x,w) ???
bootobject <- boot(???, mfun, R=nboot, stype='w')

sd(???)
hist(???)

### 2.2 Plot the data

plot(???)

### 2.3 Linear regression

# linear regression
fit <- lm(???)


## 2.4 Plot the data and fit

plot(???)
lines(???)


## 2.5 Bootstrap to find error-bars for the model parameters

nboot = 100
ffun <- function(d,i) {
  f<-lm(???)
  f$coefficients
}
bootfit <- boot(data, ffun, R=nboot, stype='i')
for (i in 1:10) {
  lines(???)
}