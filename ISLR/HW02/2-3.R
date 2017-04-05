#housekeeping
rm(list = ls())
setwd("C:/Users/kishore adur/Documents/kartik-programs/machine learning/ISLR code exercises/HW02")

#import MASS library
library("MASS")

# count rows and columns in dataset Boston
dim(Boston)
length(Boston[1,]) #rows
length(Boston[,1]) #cols
summary(Boston)

#pairwise comparisons of Boston dataset
pairs(Boston)
