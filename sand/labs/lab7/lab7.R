library(R.matlab)

data <- readMat('ec014_333_spksort_samp.mat')

# pca
pc <- prcomp(t(data$X), center = TRUE, scale. = TRUE)
plot(pc$x[,1],pc$x[,2])


# kmeans 
k <- 5
cluster <- kmeans(pc$x[,1:3], k, nstart = 20)

collist=c('red','green','blue','yellow','cyan')
plot(pc$x[,1],pc$x[,2],col='white')
for (kcount in 1:k) {
  points(pc$x[cluster$cluster==kcount,1],pc$x[cluster$cluster==kcount,2],col=collist[kcount])
}