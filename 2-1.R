#housekeeping
rm(list = ls())
setwd("C:/Users/kishore adur/Documents/kartik-programs/machine learning/ISLR code exercises/HW02")

# Applied section

## (a) read.csv() to read data file
college_data <- read.csv("College.csv")

## (b) fix() function to adjust first column to row names
rownames(college_data) <- college_data[,1]
fix(college_data)

college_data <- college_data[,-1]
fix(college_data)

## (C) i summary
summary(college_data)

## (C) ii pairs
pairs(college_data[,1:10])


## (c) iii boxplot
### only outstate~private work, the other way throws an error:
### Error in boxplot.default(split(mf[[response]], mf[-response]), ...) : 
### adding class "factor" to an invalid object
boxplot(Outstate~Private, data = college_data, xlab = "Private College", ylab = "Out of State Students")

## (c) iv binning
Elite <- rep("No", nrow(college_data)) # add new row to table
Elite[college_data$Top10perc > 50] = "Yes"
Elite <- as.factor(Elite)
college_data = data.frame(college_data, Elite)

summary(college_data)
### boxplot might throw error: Error in eval(expr, envir, enclos) : object 'ELite' not found
### if it confuses the row Elite in table college_data with variable Elite used to create that row
boxplot(Outstate~Elite, data = college_data, xlab = "Elite Colleges", ylab = "Out of state students")


## (c) v histogram
par(mfrow = c(2,2))
hist(college_data$Apps, xlab = "College Applications", main = "Apps")
hist(college_data$Accept, xlab = "College Acceptances", main = "Accept")
hist(college_data$Enroll, xlab = "Students Enrolled", main = "Enroll")
hist(college_data$Outstate, xlab = "Out of state students", main = "Outstate")


## (c) vi comparisons
par(mfrow = c(1,1))
plot(college_data$Accept, college_data$Enroll)
plot(college_data$Apps, college_data$Accept)
plot(college_data$Apps, college_data$Enroll)
plot(college_data$Outstate, college_data$Grad.Rate)
plot(college_data$Accept/college_data$Apps, college_data$S.F.Ratio)
plot(college_data$Top10perc, college_data$Grad.Rate)