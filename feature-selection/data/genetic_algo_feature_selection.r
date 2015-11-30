####################################################################################

# author - akashraj

# genetic algorithm for feature selection using random forests for fitness function

####################################################################################


#load required libraries
library("foreign")
library("randomForest")
#library("pROC")
library("ROCR")

set.seed(71)

#load data
CM1 <- read.arff("data/CleanedData/MDP/D'/CM1.arff")
CM1_train <- CM1[1:240, ]
CM1_val <- CM1[241:nrow(CM1) ,] #validation set


#random forest - train model
model.rf <- randomForest(Defective~., data = CM1_train, importance = T, proximity = T, keep.forest = T, test = CM1_val)

#to find AUC of ROC
model.rf.probability = predict(model.rf, type = "prob", newdata = CM1_val)[ ,2]
model.rf.pred = prediction(model.rf.probability, CM1_val$Defective)
model.rf.perf = performance(model.rf.pred, "tpr", "fpr")

plot(model.rf.perf, main = "ROC Curve for Random Forest", col = 2, lwd = 2)
abline(a = 0, b = 1, lwd = 2, lty = 2, col = "gray")

auc <- performance(model.rf.pred, "auc")

