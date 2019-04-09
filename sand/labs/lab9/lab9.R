
library(R.matlab)

data <- readMat('millerLab_2reach_sample.mat')



## Plot the response of 1 neuron on the different (L vs R) conditions

neuron=1;

x <- 0:(max(data$X[,neuron])+1)

hist(data$X[data$y==0,neuron],breaks=x-.5,freq=FALSE,col='black')
muR <- mean(data$X[data$y==0,neuron])
lines(x,dpois(x,muR),col='red')

hist(data$X[data$y==1,neuron],breaks=x-.5,freq=FALSE,col='gray',border='gray')
muL <- mean(data$X[data$y==1,neuron])
lines(x,dpois(x,muL),col='blue')



## Find p(L|spikes) and p(R|spikes) using Bayes rule...

pL_given_s <- dpois(x,muL)*0.5
pR_given_s <- dpois(x,muR)*0.5
ps   <- pL_given_s + pR_given_s
pLgs <- pL_given_s/ps
pRgs <- pR_given_s/ps

hist(data$X[data$y==1,neuron],breaks=x-.5,freq=FALSE,col='gray',border='gray')
par(new=TRUE)
plot(x,pLgs,ylim = c(0,1),type = 'l',col='blue')
lines(x,pRgs,col='red')


## Fit distributions (calculate means) for all neurons...

muR <- colMeans(data$X[data$y==0,])
muL <- colMeans(data$X[data$y==1,])


##  Calculate p(spikes|L) for all neurons all trials...
ppL_given_s<-data$X*0
ppR_given_s<-data$X*0
for (neuron in 1:dim(data$X)[2]) {
  for (trial in 1:dim(data$X)[1]) {
    ppL_given_s[trial,neuron] <- dpois(data$X[trial,neuron],muL[neuron])*0.5
    ppR_given_s[trial,neuron] <- dpois(data$X[trial,neuron],muR[neuron])*0.5
    ps  <- ppL_given_s[trial,neuron]+ppR_given_s[trial,neuron]
    ppL_given_s[trial,neuron] <- ppL_given_s[trial,neuron]/ps
    ppR_given_s[trial,neuron] <- ppR_given_s[trial,neuron]/ps
  }
}

image(ppL_given_s)


## Use naive bayes assumption

ppL_given_S <- apply(ppL_given_s, 1, prod)
ppR_given_S <- apply(ppR_given_s, 1, prod)
pS  <- ppL_given_S+ppR_given_S
ppL_given_S <- ppL_given_S/pS
ppR_given_S <- ppR_given_S/pS

yhat <- ppL_given_S
plot(yhat)
sum((yhat>0.5)==data$y)/dim(data$y)[1]




# Less manual version...
#install.packages('e1071')
library(e1071)
help(naiveBayes)