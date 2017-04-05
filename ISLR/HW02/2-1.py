import numpy as np
import pandas as pd
from pandas.tools.plotting import scatter_matrix
import matplotlib.pyplot as plt

## (a) Import csv as data frame
college = pd.read_csv("College.csv")

## (0-0) test data frame exisits
print(college.head(10))
print(college.tail(10))
print(list(college)[0])

# (b) Convert first column to row names
newColNames = ["University name"] + list(college)[1:]
##print(newColNames)
college.columns = newColNames
##print(college.head(10))
college.set_index(list(college)[0], inplace = True)
##print(college.head(10))

# (c) i : summary
print(college.describe())

# (c) ii : pairs (pairwise scatter plot of first 10 columns)
scatter_matrix(college.ix[:,0:11], diagonal = 'kde')
plt.show()

# (c) iii : box plot of Outstate and Private
college.boxplot(column = 'Outstate', by = 'Private')
plt.show()

# (c) iv : new qualitative variable Elite based on Top10perc > 50
# followed by box plot of OUtstate vs. Elite
college['Elite'] = 'No'
college['Elite'] = college['Top10perc'].map(lambda x: 'Yes' if x > 50 else 'No')
print(college['Elite'].describe())

college.boxplot(column = 'Outstate', by = 'Elite')
plt.show()

# (c) v : histograms of four different comparisons
college.hist(column = 'Apps')
college.hist(column = 'Accept')
college.hist(column = 'Enroll')
plt.show()

# (c) vi : comparison plots
college.plot.scatter(x = 'Apps', y = 'Enroll')
college.plot.scatter(x = 'Outstate', y = 'Grad.Rate')

college['AcceptDivByApps'] = college['Accept']/college['Apps']

college.plot.scatter(x = 'AcceptDivByApps', y = 'Grad.Rate')
plt.show()
