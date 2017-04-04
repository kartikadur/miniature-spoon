for (i in c(6,7,8,9)) {
  print(1 - ppois(1, i))
  print(ppois(1, i, lower.tail = FALSE))
}
