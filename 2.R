#Preliminaries
rm(list = ls())
library("utils")
setwd("C:/Users/kishore adur/Documents/kartik-dass/homework/HW02/Gender_Stats_csv")
#Getting the data
gender_data <- read.csv("GenderStat_Data.csv")
teenager_fr <- subset(gender_data, Indicator.Code == "SP.ADO.TFRT")

str(teenager_fr)
head(teenager_fr)
tail(teenager_fr)

mean(teenager_fr$X1960, na.rm = TRUE)
#[1] 101.1481
sd(teenager_fr$X1960, na.rm = TRUE)
#[1] 53.69716
mean(teenager_fr$X1960, na.rm = TRUE)
#[1] 101.1481
mean(teenager_fr$X2000, na.rm = TRUE)
#[1] 62.72049
sd(teenager_fr$X2000, na.rm = TRUE)
#[1] 46.60511

#Plotting the mean, and the value for low income, middle income, and high income countries
low_income <- subset(teenager_fr, Country.Code == "LIC")
middle_income <- subset(teenager_fr, Country.Code == "MIC")
high_income <- subset(teenager_fr, Country.Code == "HIC")
plot_frame <- matrix(NA, 5, 55)
for (i in 5:59){
  k <- i - 4
  j <- i + 1955
  plot_frame[1, k] <- j
  plot_frame[2, k] <- mean(teenager_fr[, i], na.rm = TRUE)
  plot_frame[3, k] <- low_income[, i]
  plot_frame[4, k] <- middle_income[, i]
  plot_frame[5, k] <- high_income[, i]
}
xlim <- range(c(plot_frame[1,]))
ylim <- range(c(plot_frame[2,], plot_frame[3,],
                plot_frame[4,], plot_frame[5,]))
plot(plot_frame[1,], plot_frame[2,], type = "l", col =
       "black", xlim=xlim, ylim=ylim,
     main = "Evolution of Adolescent Fertility Rate",
     xlab = "year", ylab = "rate")
lines(plot_frame[1,], plot_frame[3,], col = "red")
lines(plot_frame[1,], plot_frame[4,], col = "blue")
lines(plot_frame[1,], plot_frame[5,], col = "yellow")

p1 <- hist(teenager_fr$X1960, breaks = 100)
p2 <- hist(teenager_fr$X2000, breaks = 100)
plot( p2, col=rgb(1,0,1,1/4), xlim = c(0, 250), main = "Change in the distribution", xlab = "values")
plot( p1, col=rgb(0,0,1,1/4), xlim = c(0, 250), add = TRUE)
legend("topright", ncol = 2, legend = c("2000", "1960"),
       fill=c(rgb(1,0,1,1/4), rgb(0,0,1,1/4)), text.width = 20)
#png("histogram")
plot.show()

p1 <- hist(teenager_fr$X1960, freq = FALSE, breaks = 20)
p2 <- hist(teenager_fr$X2000, freq = FALSE, breaks = 20)
p1$counts = p1$density
p2$counts = p2$density
p3 <- density(teenager_fr$X1960, na.rm = TRUE)
p4 <- density(teenager_fr$X2000, na.rm = TRUE)
plot( p2, col=rgb(1,0,1,1/4), xlim = c(0, 250), main = "Change in the distribution", xlab = "values", ylab = "Density")
plot( p1, col=rgb(0,0,1,1/4), xlim = c(0, 250), add = TRUE)
lines( p4, col=rgb(1,0,1,1/4), xlim = c(0, 250), lwd = 5)
lines(p3, col=rgb(0,0,1,1/4), xlim = c(0, 250), lwd = 5)
legend("topright", ncol = 2, legend = c("2000", "1960"),
       fill=c(rgb(1,0,1,1/4), rgb(0,0,1,1/4)), text.width = 20)
legend("topright", ncol = 2, legend = c("2000", "1960"),
       fill=c(rgb(1,0,1,1/4), rgb(0,0,1,1/4)), text.width = 20)