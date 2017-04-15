from thinkbayes import Suite

class Train(Suite):

    def __init__ (self, hypos, alpha = 1.0):
        Suite.__init__(self)
        for hypo in hypos:
            self.Set(hypo, hypo ** (-alpha))
        self.Normalize()
     
    def Likelihood(self, data, hypo):
        if hypo < data :
            return 0
        else :
            return 1/hypo

    def Summary(self):
        print('MaxLikelihood', self.MaximumLikelihood())

        print('Mean', self.Mean())
        print('Median', self.Median())
        
        print('5th Percentile', self.Percentile(5))
        print('95th Percentile', self.Percentile(95))
        
        print('Confidence Interval', self.CredibleInterval(90))
        

if __name__ == '__main__':
    hypos = [500,1000, 2000]

    for lim in hypos:
        suite = Train(range(1, lim + 1))

        for data in [60, 30,90]:
            suite.Update(data)

        print('\nLimit : ', lim)
        suite.Summary()
