from sklearn.datasets import load_boston
from pandas.tools.plotting import scatter_matrix
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import pandas as pd

##(a)
boston = load_boston()
boston_df = pd.DataFrame(boston.data, columns = boston.feature_names)

##data frame dimensions
print(boston_df.describe())
##Column data
##CRIM -- per capita crime rate by town
##ZN -- proportion of residential land zoned for lots over 25,000 sq.ft.
##INDUS -- proportion of non-retail business acres per town
##CHAS -- Charles River dummy variable (1 if tract bounds river, 0 otherwise)
##NOX -- nitric oxides concentration (parts per 10 million)
##RM -- Average number of rooms per dwelling
##AGE -- proportion of owner occupied units built prior to 1940
##DIS -- weighted distances to five Boston employment centres
##RAD -- index of accessibility of radial highways
##TAX -- full-value property tax per $10,000
##PTRATIO -- pupil to teacher ration by town
##B - 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
##LSTAT -- % lower status of the population
##MEDV -- Median value of owner occupied homes in $1000's

# (b)
scatter_matrix(boston_df)
plt.show()
###Findings of pairwise plots (or in this case scatter plots)
##AGE and NOX are correlated
##RM is nearly constant at (around) 6 for any given AGE
##RAD are less than 10 or greater than 20

# (c)

fig, axes = plt.subplots(nrows = 4, ncols = 3)
## axes is 2D array, flatten it to 1D and initialize axes_ix to track subplot index in axes
axes = [c for r in axes for c in r]
axes_ix = 0

for xname in list(boston_df)[1:]:
    boston_df.plot(x = xname, y = 'CRIM', kind = 'scatter', ax = axes[axes_ix])
    axes_ix += 1

plt.tight_layout()
plt.show()

boston_corr = boston_df.corr(method = 'pearson').iloc[0]
print(boston_corr)
##CRIM       1.000000
##ZN        -0.199458
##INDUS      0.404471
##CHAS      -0.055295
##NOX        0.417521
##RM        -0.219940
##AGE        0.350784
##DIS       -0.377904
##RAD        0.622029
##TAX        0.579564
##PTRATIO    0.288250
##B         -0.377365
##LSTAT      0.452220
##Name: CRIM, dtype: float64

best_corr = boston_corr[(boston_corr > 0.5) | (boston_corr < -0.5)][1:]
print(best_corr)
##RAD    0.622029
##TAX    0.579564
##Name: CRIM, dtype: float64
