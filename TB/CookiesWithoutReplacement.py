## New Cookie Without replacement
from Suite import Suite
class CookieWithoutReplacement(Suite):

    mixes = {
        'Bowl 1': dict(vanilla = 30, chocolate = 10),
        'Bowl 2': dict(vanilla = 20, chocolate = 20)
        }

    def Likelihood(self, data, hypo):
        mix = self.mixes[hypo]
        like = mix[data]/sum(self.mixes[hypo].values())
        if like:
            mix[data] -= 1
        return like

if __name__ == '__main__':
    hypos = ['Bowl 1', 'Bowl 2']

##  single draw
    cwor = CookieWithoutReplacement(hypos)
    cwor.Update('vanilla')
    for hypo, prob in cwor.Items():
        print(hypo, prob)

##  multiple draws without replacement
    dataset = ['vanilla', 'chocolate', 'vanilla']
    for data in dataset:
        cwor.Update(data)
    for hypo, prob in cwor.Items():
        print(hypo, prob)
