
library(R.matlab)
data <- readMat('data_v1_binned_static.mat')


dataset_number = 8
stimulus_conditions = data$data[[dataset_number]][[1]][[3]]

# conditions to compare
condition_1 = 2
condition_2 = 10

# neuron x conditions x time x trials
spikes = data$data[[dataset_number]][[1]][[6]][,,,]

# responses to conditions summed over time
spikes_1 = spikes[,condition_1,,]
spikes_2 = spikes[,condition_2,,]

X_1 = t(apply(spikes_1, MARGIN=c(1,3), sum))
X_2 = t(apply(spikes_2, MARGIN=c(1,3), sum))
X = rbind(X_1,X_2)
y = c(rep(0,each=dim(X_1)[1]),rep(1,each=dim(X_2)[1]))
image(X)


# logistic regression
model <- glm(y~X, family = binomial(link = "logit"))
fitted.results <- predict(model,type='response')
fitted.results <- ifelse(fitted.results > 0.5,1,0)
accuracy <- mean(fitted.results == y)
print(accuracy)