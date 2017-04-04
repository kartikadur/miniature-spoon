#comparing english auction (col 1) vs. posted price (col 2) sales

for (N in 1:10) {
  expected_revenue <- c((N-1)/(N+1),(N/(N+1)) * 1/((N+1)^(1/N)))
  print(expected_revenue)
}

#class solution code code
rm(list = ls())
library(mvtnorm)

#Uniform valuations
number_of_bidders <- 3
N <- number_of_bidders
V <- 10000

set.seed(5)
valuations <- matrix(runif(
  N*V, min = 0, max = 1),
  nrow = V
)

maximum_valuation <- apply(valuations, 1, max)
optimal_price <- 1/((N+1)^(1/N))
expected_revenue_posted <- (N/(N+1)) * 1/((N+1)^(1/N))

revenue <- optimal_price * (maximum_valuation >= optimal_price)
mean(revenue)
expected_revenue_posted

#comparison with English Auction
rank_of_valuations <- apply(valuations, 1, rank)
price_english_auction <- apply(valuations, 1, function(x)
  (x[rank(x) == N- 1]))
expected_revenue_english <- (N-1)/(N+1)

mean(price_english_auction)
expected_revenue_english