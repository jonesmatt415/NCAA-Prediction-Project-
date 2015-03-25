rm(list=ls())

vec = c(1,2,3,4,5,6,7)
mean(vec)

ncaa2006 = read.table("C:\\Users\\Matt\\Desktop\\R_files\\ncaa-2006.txt",header=T)

x = as.matrix(ncaa2006[4:14])
y1 = 1:32
y1 = y1 * 0+1
y2 = y1 * 0
y = c(y1,y2)
library(MASS)
dm = lda(y~x)

dm$prior
dm$mean
dm$call
dm$N
dm$svd
predict(dm)$class
predict(dm)
y_pred = predict(dm)$class
length(y_pred)
table(y,y_pred)

result = princomp(x)
screeplot(result)
screeplot(result,type="lines")
summary(result)
result$loadings
biplot(result)

names(ncaa2006)
d = dist(ncaa2006[,3:14],method="euclidian")
fit = kmeans(ncaa2006[,3:14],4)
fit$size
fit$centers
idx = c(4,6)
idx
plot(ncaa2006[,idx],col=fit$cluster)

fit2 = hclust(d,method="ward.D")
names(fit2)
plot(fit2,main="NCAA Teams")
groups = cutree(fit2,k=4)
rect.hclust(fit2,k=4,border="blue")
groups
library(cluster)
clusplot(ncaa2006[,3:14],groups,color=TRUE,shade=TRUE,labels=2,lines=0)










