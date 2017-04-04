rm(list = ls())
setwd("C:/Users/kishore adur/Documents/kartik-dass/homework/HW09")


#---------- << Part 1 >> ----------

# get wage data
wage_data <- read.csv("nlsw88.csv")

# formula = Y_i ~ X_i where Y_i <- lwage and X_i <- yrs_school
l_model <- lm(formula = lwage ~ yrs_school, wage_data)
summary(l_model)

#confidence intervals
ci_95 <- confint(l_model) # default for 95%
ci_90 <-confint(l_model, level = 0.90) # for 90%

#sum of residuals -> 2.945734e-14 ~ 0
r <- sum(residuals(l_model))


#---------- << Part 2 >> ----------

# formula = Y_i ~ X_i where Y_i <- lwage and X_i <- black
l_model_b <- lm(formula = lwage ~ black, wage_data)
summary(l_model_b)

#testing using beta_0 and beta_i
meanother <- mean(wage_data$lwage[wage_data$black == 0])
meanblack <- mean(wage_data$lwage[wage_data$black == 1])
#beta_0
meanother
#beta_1
meanblack - meanother


#---------- << Part 3 >> ----------
#linear model with two or more X_i
l_model_2vars <- lm(formula = lwage ~ yrs_school + ttl_exp, wage_data)
summary(l_model_2vars)

#restricted model where 2*b_1 = b_2
l_model_2v_restricted <- lm(formula = lwage ~ I(yrs_school + 2*ttl_exp), wage_data)
summary(l_model_2v_restricted)

#analysis of variance (anova test)
#((SSR_r - SSR_u)/r)/(SSR_u/(n-k+1))
anova_unrest <- anova(l_model_2vars)
anova_rest <- anova(l_model_2v_restricted)

stat_test <- (((anova_rest$'Sum Sq'[2] - anova_unrest$'Sum Sq'[3])/1)
              /(anova_unrest$'Sum Sq'[3]/anova_unrest$Df[3]))
stat_test

pvalue <- df(stat_test, 1, anova_unrest$Df[3])

pvalue