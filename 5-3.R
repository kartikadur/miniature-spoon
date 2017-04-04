#rm(list = ls())

#setwd("C:/Users/kishore adur/Documents/kartik-dass/HW05")
#data <- read.csv('cartier+3-day+auctions.csv')

#get total number of auctions
#unique(data$auctionid)

# code to get auctionid, ration of second highest to third highest bid,
# number of bidders, and number of bids

rm(list = ls())

cartier_data <- read.csv('cartier+3-day+auctions.csv')
cartier_data$auctionid <- as.character(cartier_data$auctionid)
unique_bids <- unique(cartier_data$auctionid)

ratio <- rep(NA, times = length(unique_bids))
number_of_bidders <- rep(NA, times = length(unique_bids))
number_of_bids <- rep(NA, times = length(unique_bids))

for (i in c(1:length(unique_bids))) {
  temp <- subset(cartier_data, cartier_data$auctionid == unique_bids[i])
  bid2 <- temp$bid[rank(temp$bid, ties.method = 'last') == (length(temp$bid) - 1)]
  bid3 <- temp$bid[rank(temp$bid, ties.method = 'last') == (length(temp$bid) - 2)]
  
  ratio[i] <- bid2/bid3
  number_of_bidders[i] <- length(unique(temp$bidder))
  number_of_bids[i] <- length(temp$bid)
}

data.clean <- data.frame(unique_bids, ratio, number_of_bidders, number_of_bids)
