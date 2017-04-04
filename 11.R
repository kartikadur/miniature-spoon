rm(list = ls())
setwd("C:/Users/kishore adur/Documents/kartik-dass/homework/HW11")

# -- possible libraries to use ---
library(car)
library(rdd)

# --- part 1 --- census80
census80 <- read.csv("census80.csv")
summary(census80)

# find proportion of houses where the first two children have the same sex
  # -- my solution --
  samesex <- ifelse(census80$sex1st == census80$sex2nd, 1, 0)
  sum(samesex) #214503
  length(samesex) #427418
  sum(samesex)/length(samesex) #0.5018577 ~0.5019
  
  # --- their solution ---
  census80$samesextemp <- ifelse(census80$sex1st == census80$sex2nd, 1, 0)
  summary(census80$samesextemp)
  
#find proportion of houses that had multiple children during the mother's 2nd pregnancy
  # -- my solution --
  sameage <- ifelse(census80$ageq2nd == census80$ageq3rd, 1, 0)
  sum(sameage, na.rm = TRUE) #3116
  length(sameage) #427418
  sum(sameage, na.rm = TRUE)/length(sameage) #0.007290287 ~0.0073
  
  # -- their solution --
  census80$sameagetemp[census80$ageq2nd == census80$ageq3rd] <- 1
  census80$multiple <- 0
  census80$multiple[census80$sameagetemp == 1] <- 1
  summary(census80$multiple)
  
# laboursupply_h = alpha_0 +
#                   alpha_1 * house-with-3-children +
#                   alpha_2 * black-mother +
#                   alpha_3 * hispanic-mother +
#                   alpha_4 * other-race-mother +
#                   error
  # -- my solution --
  census80$hw3children <- ifelse(census80$numberkids == 3, 1, 0)
  model <- lm(workedm ~ hw3children + blackm + hispm + othracem, data = census80)
  summary(model) #hw3children --> -0.0839132 ~ -8.39%
  model2 <- lm(weeksm ~ hw3children + blackm + hispm + othracem, data = census80)
  summary(model2) #hw3children --> -3.94018 ~ -3.94 weeks
  
  # -- their solution --
  census80$hw3children <- ifelse(census80$numberkids == 3, 1, 0)
  ols1 <- lm(workedm ~ hw3children + blackm + hispm + othracem, data = census80)
  pvalue <- summary(ols1)
  OLS <- cbind(c(ols1$coefficients[2], pvalue$coefficients[2,4]))
  
  ols2 <- lm(weeksm ~ hw3children + blackm + hispm + othracem, data = census80)
  pvalue <- summary(ols2)
  OLS <- cbind(OLS, c(ols2$coefficients[2], pvalue$coefficients[2,4]))
  
  OLS
# By having a multiple pregnancy during the second pregnancy,
  #the likelyhood of having a third child increases
  #by how many percentage points
# third_child = alpha_0 +
#               alpha_1 * multiple-pregnancies + 
#               alpha_2 * black-mother +
#               alpha_3 * hispanic-mother +
#               alpha_4 * other-race-mother +
#               error
  # -- my solution --
  model <- lm(hw3children ~ multiple + blackm + hispm + othracem, data = census80)
  summary(model)
  # -- their solution --
  firststage1 <- lm(hw3children ~ multiple + blackm + hispm + othracem, data = census80)
  pvalue <- summary(firststage1)
  FirstStage <- cbind(c(firststage1$coefficients[2], pvalue$coefficients[2,4]))
  
  FirstStage
  
# when the first two children are the same sex, 
  #the likelyhood of having a third child increases 
  #by how many percentage points?
# third_child = alpha_0 +
#               alpha_1 * same-sex + 
#               alpha_2 * black-mother +
#               alpha_3 * hispanic-mother +
#               alpha_4 * other-race-mother +
#               error
  # -- my solution --
  model <- lm(hw3children ~ samesextemp + blackm + hispm + othracem, data = census80)
  summary(model)
  
  # -- their solution --
  firststage2 <- lm(hw3children ~ samesextemp + blackm + hispm + othracem, data = census80)
  pvalue <- summary(firststage2)
  FirstStage <- cbind(FirstStage, c(firststage2$coefficients[2], pvalue$coefficients[2,4]))
  
  FirstStage
  
  
# IV regression
  library(AER)
  
  # -- my solution --
  # instrument variable --> multple (twins or more during second pregnancy)
  iva1 <- ivreg(workedm ~ hw3children + blackm + hispm + othracem |
                  blackm + hispm + othracem + multiple, data = census80)
  pvalue <- summary(iva1)
  IVa <- cbind(c(iva1$coefficients[2], pvalue$coefficients[2,4]))
  
  IVa
  
  iva2 <- ivreg(weeksm ~ hw3children + blackm + hispm + othracem |
                  blackm + hispm + othracem + multiple, data = census80)
  pvalue <- summary(iva2)
  IVa <- cbind(IVa, c(iva2$coefficients[2], pvalue$coefficients[2,4]))
  
  IVa
  
  # -- my solution --
  # instrument variable --> samesextemp (first two children have the same sex)
  ivb1 <- ivreg(workedm ~ hw3children + blackm + hispm + othracem |
                  blackm + hispm + othracem + samesextemp, data = census80)
  pvalue <- summary(ivb1)
  IVb <- cbind(c(ivb1$coefficients[2], pvalue$coefficients[2,4]))
  
  IVb
  
  ivb2 <- ivreg(weeksm ~ hw3children + blackm + hispm + othracem |
                  blackm + hispm + othracem + samesextemp, data = census80)
  pvalue <- summary(ivb2)
  IVb <- cbind(IVb, c(ivb2$coefficients[2], pvalue$coefficients[2,4]))
  
  IVb