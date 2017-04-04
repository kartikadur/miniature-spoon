for (i in 10:60) {
  print(c(i, phyper(0,6,94,i),dhyper(0,6,94,i)))
}

for (i in 10:60) {
  print(c(i, phyper(1,6,94,i),dhyper(0,6,94,i)+dhyper(1,6,94,i)))
}