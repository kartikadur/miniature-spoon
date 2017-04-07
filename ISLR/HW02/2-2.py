import pandas as pd
import numpy as np
from pandas.tools.plotting import scatter_matrix, bootstrap_plot
import matplotlib.pyplot as plt

##Read data file
auto = pd.read_csv("Auto.data", sep = '\s+', header = 0)
##na.omit equivalent to remove rows with '?' in them
auto = auto[auto['horsepower'] != '?']
auto['horsepower'] = auto.horsepower.astype(float)
##Test data frame
print(auto.head(10))
##print(auto.tail())
print(auto.describe())
##print(list(auto))

## range, mean, and standard deviation for columns
## only use first 7 columns
rownames = list(['min', 'max', 'mean', 'sd'])
vals = pd.DataFrame([auto.ix[:,0:6].min(), auto.ix[:,0:6].max(), auto.ix[:,0:6].mean(), auto.ix[:,0:6].std()], index = rownames)
print(vals)


##compare data
axes = scatter_matrix(auto)
plt.show()
##Now with subplots :)
fig, axes = plt.subplots(nrows = 2, ncols = 2)


ax1 = auto.plot(x = 'weight', y = 'mpg', c = 'displacement', kind = 'scatter', ax = axes[0, 0], rot = 45)

auto.plot(x = 'horsepower', y = 'mpg', c = 'acceleration', kind = 'scatter', ax = axes[0, 1])

auto.boxplot(column = 'mpg', by = 'cylinders',  ax = axes[1, 0])
auto.boxplot(column = 'mpg', by = 'year', ax = axes[1, 1])
##Add super title common to all subplots
plt.suptitle("Comparison of factors that affect mileage of cars")
##Margins and padding where the canvas width and height are 1 and left, right, bottom, and top are the fraction on that scale
fig.subplots_adjust( left = 0.1, bottom = 0.1, right = 0.9, top = 0.9, wspace = 0.3, hspace = 0.5)

##plt.tight_layout()
plt.show()
