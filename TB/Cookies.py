from thinkbayes import Suite

class Cookie(Suite):

    mixes = {
    'Bowl 1':dict(vanilla=0.75, chocolate=0.25),
    'Bowl 2':dict(vanilla=0.5, chocolate=0.5),
    }

    def Likelihood(self, data, hypo):
        mix = self.mixes[hypo]
        like = mix[data]
        return like

if __name__ == '__main__':
    hypos = ["Bowl 1", "Bowl 2"]

##  single draw
    pmf = Cookie(hypos)
    pmf.Update('vanilla')
    for hypo, prob in pmf.Items():
        print(hypo, prob)

##  multiple draws with replacement
##    pmf = Cookie(hypos)
    dataset = ['vanilla', 'chocolate', 'vanilla']
    for data in dataset:
        pmf.Update(data)
    for hypo, prob in pmf.Items():
        print(hypo, prob)

