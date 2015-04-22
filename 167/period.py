class Period(object):
    def __init__(self, u, period_start):
        self.period_start = period_start
        self.minimum_period = 20
        self.diffs = []
        self.previous = u.compute(period_start)
        self.u = u
        self.period = self.compute_period()

    def compute_period(self):
        period_length = self.minimum_period
        while not self.verify_period(period_length):
            period_length += 1
        return self.diffs[0:period_length]

    def verify_period(self, period_length):
        i = period_length
        while i <= 2*period_length:
            if self.lookup_diff(i) != self.lookup_diff(i % period_length):
                return False
            i += 1
        return True

    def lookup_diff(self, i):
        while i >= len(self.diffs):
            s = self.u.compute(self.period_start + 1 + len(self.diffs))
            self.diffs.append(s - self.previous)
            self.previous = s
        return self.diffs[i]

    def compute(self, k):
        if k <= self.period_start:
            return self.u.compute(k)
        fundamental_difference = sum(self.period)
        base = self.u.compute(self.period_start) + fundamental_difference*((k - self.period_start)/len(self.period))
        return base + sum(self.period[0:(k - self.period_start)%len(self.period)])
