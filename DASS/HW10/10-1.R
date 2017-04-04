#environment setup
rm(list = ls())
setwd("C:/Users/kishore adur/Documents/kartik-dass/homework/HW10")
library('rdd') # loads a few dependent libs

# -- get data -- #
elections <- read.csv('indiv_final.csv')

#what is the proportion of cases where 
# the candidate is the same party as the incumbent
elections$same_party <- ifelse(elections$difshare >= 0, 1, 0)
same_party_pc <- length(which(elections$same_party == 1))/length(elections$same_party)

#run DCdensity on elections$difshare
dc_density_difshare <- DCdensity(elections$difshare, ext.out = TRUE)

#required vars
elections$df2 <- elections$difshare ^ 2
elections$df3 <- elections$difshare ^ 3
elections$dfxsp <- elections$difshare * elections$same_party
elections$df2xsp <- elections$df2 * elections$same_party
elections$df3xsp <- elections$df3 * elections$same_party

model <- lm(myoutcomenext ~ same_party, data = elections, subset = abs(difshare) <= 0.5)
coeff_matrix <- cbind(c(model$coefficients[2], summary(model)$coefficients[2,4]))
model <- lm(myoutcomenext ~ same_party + difshare, data = elections, subset = abs(difshare) <= 0.5)
coeff_matrix <- cbind(coeff_matrix, c(model$coefficients[2], summary(model)$coefficients[2,4]))
model <- lm(myoutcomenext ~ same_party + difshare + dfxsp, data = elections, subset = abs(difshare) <= 0.5)
coeff_matrix <- cbind(coeff_matrix, c(model$coefficients[2], summary(model)$coefficients[2,4]))
model <- lm(myoutcomenext ~ same_party + difshare + df2, data = elections, subset = abs(difshare) <= 0.5)
coeff_matrix <- cbind(coeff_matrix, c(model$coefficients[2], summary(model)$coefficients[2,4]))
model <- lm(myoutcomenext ~ same_party + difshare + df2 + dfxsp + df2xsp, data = elections, subset = abs(difshare) <= 0.5)
coeff_matrix <- cbind(coeff_matrix, c(model$coefficients[2], summary(model)$coefficients[2,4]))
model <- lm(myoutcomenext ~ same_party + difshare + df2 + df3, data = elections, subset = abs(difshare) <= 0.5)
coeff_matrix <- cbind(coeff_matrix, c(model$coefficients[2], summary(model)$coefficients[2,4]))
model <- lm(myoutcomenext ~ same_party + difshare + df2 + df3 + dfxsp + df2xsp + df3xsp, data = elections, subset = abs(difshare) <= 0.5)
coeff_matrix <- cbind(coeff_matrix, c(model$coefficients[2], summary(model)$coefficients[2,4]))

coeff_matrix

#non parametric
model <- RDestimate(formula = myoutcomenext ~ difshare, data = elections, subset = abs(elections$difshare) <= 0.5)
summary(model)
