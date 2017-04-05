#housekeeping
rm(list = ls())
setwd("C:/Users/kishore adur/Documents/kartik-programs/machine learning/ISLR code exercises/HW02")

auto <- read.table("Auto.data", na.strings = "?", header = TRUE)
auto <- na.omit(auto)

# range values for quantitative vars (columns 1 thru 7 of total 9)
# mean and standard deviation of the same columns
# version 1
for(i in seq_along(auto[,1:7])) {
  coln <- colnames(auto[i])
  colr <- range(auto[,i])
  colm <- mean(auto[,i])
  cols <- sd(auto[,i])
  print(paste(coln, ": range ", colr[1], colr[2],
               "mean ", colm[1],
               "standard deviation ", cols[1]))
}
# version 2
for( c in names(auto[,1:7]) ){
  
  colr <- range(auto[[eval(c)]])
  colm <- mean(auto[[eval(c)]])
  cols <- sd(auto[[eval(c)]])
  print(paste(c, ": range ", colr[1], colr[2],
              "mean ", colm[1],
              "standard deviation ", cols[1]))
}
# based on book solutions
# sapply(Auto[, 1:7], range)
# sapply(Auto[, 1:7], mean)
# sapply(Auto[, 1:7], sd)
#my solution based on book solutions that uses multiple functions with sapply
multifuncs <- function(x) {
  c(range = range(x),
    mean = mean(x),
    sd = sd(x))
}
sapply(auto[,1:7], multifuncs)
#remove rows 10 through 85
adjustedauto = auto[-(10:85),]
rownames(adjustedauto) <- 1:nrow(adjustedauto)
sapply(auto[,1:7], multifuncs)

#compare column data
pairs(auto)
par(mfrow = c(2,2))
plot(auto$mpg, auto$cylinders) # inversely correlated
plot(auto$mpg, auto$weight) # inversely correlated
plot(auto$mpg, auto$horsepower) # inverserly correlated
plot(auto$mpg, auto$year) # improvement of mpg over the years