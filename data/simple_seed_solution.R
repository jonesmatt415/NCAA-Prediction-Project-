rm(list=ls())

# Load Data

setwd("C:\\Users\\Matt\\Desktop\\Kaggle2015")


teams <- read.csv("Data/teams.csv", header = TRUE, stringsAsFactors = FALSE)
matches <- read.csv("Data/sample_submission_2015.csv", header = TRUE, stringsAsFactors = FALSE)
seeds <- read.csv("Data/tourney_seeds_2015.csv", header = TRUE, stringsAsFactors = FALSE)

matches$year <- sapply(matches$id, FUN=function(x) {strsplit(x, split='[_]')[[1]][1]})
matches$lowId <- sapply(matches$id, FUN=function(x) {strsplit(x, split='[_]')[[1]][2]})
matches$highId <- sapply(matches$id, FUN=function(x) {strsplit(x, split='[_]')[[1]][3]})

seeds <- subset(seeds, season >= 2015)
seeds$seedNumber <- as.numeric(substring(seeds$seed, 2, 3))

matches <- cbind(matches, merge(matches, seeds, by.x=c("year","lowId"), by.y=c("season","team"))["seedNumber"])
colnames(matches)[6] <- "lowIdSeed"

test <- merge(matches, seeds, by.x=c("year","highId"), by.y=c("season","team"))
test <- test[order(test$id), ]

matches <- cbind(matches, test["seedNumber"])
colnames(matches)[7] <- "highIdSeed"
rownames(matches) <- NULL

matches$calculated <- 0.50 + (matches$highIdSeed - matches$lowIdSeed)*0.03
submit <- data.frame(id = matches$id, pred = matches$calculated)
write.csv(submit, file = "Output/simple_seed_solution.csv", row.names = FALSE, quote=FALSE)

