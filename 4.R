rm(list = ls())
library('utils')
library('plot3D')
setwd("C:/Users/kishore adur/Documents/kartik-dass/homework/HW04")

#Creating the vector X and Y
#M <- mesh(seq(0, 1, length = 100), seq(0, 1, length = 100))
#x <- M$x
#y <- M$y
#z <- 6/5*(M$x + M$y^2)

#plotting this pdf
#persp3D(x, y, z, xlab = 'X Variable', ylab = 'Y variable',
       # xlim = c(0,1), main = 'Plotting the joint pdf')


#Creating the vector X and Y
M <- mesh(seq(0, 1, length = 100), seq(0, 1, length = 100))
x <- M$x
y <- M$y
z <- 1.2*(M$x + M$y^2)
zx <- 1.2*(M$x + 1/3)
zy <- 1.2*(1/2 + M$y^2)
# multiply zx and zy by z to produce P(x|y) and P(y|x) respectively
px <- ecdf(zx * z)
py <- ecdf(zy * z)
#plotting this pdf
plot(px, verticals = TRUE, do.points = FALSE, col = 'red')
plot(py, verticals = TRUE, do.points = FALSE, add = TRUE, col = 'cyan')