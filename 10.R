rm(list = ls())
setwd("C:/Users/kishore adur/Documents/kartik-dass/homework/HW10")

# -- get data -- #

fastfood <- read.csv('fastfood.csv')

# What is the average difference between fast-food restaurants 
# located in NJ and Pennsylvania in terms of the number of full-time employees?
model1 <- lm(empft ~ state, data = fastfood)
model2 <- lm(emppt ~ state, data = fastfood)
model3 <- lm(wage_st ~ state, data = fastfood)
summary(model1)
summary(model2)
summary(model3)

#new model empft_i2 - empft_i1 = alpha_0 + alpha_1*state_i + v_i
fastfood$empft_diff <- (fastfood$empft2 - fastfood$empft)
model4 <- lm(empft_diff ~ state, data = fastfood)
summary(model5)