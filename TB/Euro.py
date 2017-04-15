from math import ceil
from thinkbayes import Suite
import matplotlib.pyplot as plt

class Euro(Suite):

    def __init__(self, prior_type = 'uniform'):
        Suite.__init__(self)
        rangemin, rangemax = 0, 101
        if prior_type == 'uniform':
            priors = map(lambda x: (x, 1), range(rangemin, rangemax))
        elif prior_type == 'triangle':
            rangemid = ceil((rangemin + rangemax) / 2)
            priors = map(lambda x: (x, x) if x < rangemid else (x, rangemax - x), range(rangemin, rangemax))

        for val, prob in priors:
            self.Set(val, prob)
        self.Normalize()

    def Likelihood(self, data, hypo):
        x = hypo/100
        if data == 'H':
            return x
        else :
            return 1 - x

    def Summary(self):
        print('MaxLikelihood', self.MaximumLikelihood())

        print('Mean', self.Mean())
        print('Median', self.Median())
        
        print('5th Percentile', self.Percentile(5))
        print('95th Percentile', self.Percentile(95))
        
        print('Confidence Interval', self.CredibleInterval(90))

    def ComparePlot(self, compare):
        ax1 = plt.subplot(211)
        plt.plot(*zip(*self.Items()), lw = 2)

        ax2 = plt.subplot(212, sharex = ax1)
        plt.plot(*zip(*compare.Items()), lw = 2, c = 'r')
        plt.show()


if __name__ == '__main__':

    dataset = 'H' * 110 + 'T' * 110

    euro1 = Euro('uniform')
    euro2 = Euro('triangle')
    
    euro1.UpdateSet(dataset)
    euro2.UpdateSet(dataset)

    euro1.Summary()
    euro2.Summary()

    euro1.ComparePlot(euro2)
