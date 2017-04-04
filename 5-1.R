#Uniform valuations
number_of_bidders <- 2
N <- number_of_bidders
#V <- c(10, 100, 1000, 10000)
V <- 10000

set.seed(5)
valuations <- matrix(runif(
  N*V, min = 0, max = 1),
  nrow = V
)

maximum_valuation <- apply(valuations, 1, max)
optimal_price <- 1/((N+1)^(1/N))
expected_revenue <- (N/(N+1)) * 1/((N+1)^(1/N))

revenue <- optimal_price * (maximum_valuation >= optimal_price)
mean(revenue)
expected_revenue