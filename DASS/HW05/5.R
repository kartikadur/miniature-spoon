rm(list = ls())
#setwd("C:/Users/kishore adur/Documents/kartik-dass/homework/HW05")

#Uniform Valuations
number_of_bidders <- 2
number_of_simulations <- 1000

set.seed(1)
valuations1 <- matrix(runif(
  number_of_bidders*number_of_simulations, min = 0, max = 1),
  nrow = number_of_simulations
  )
