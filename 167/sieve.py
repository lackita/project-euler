import unittest

class U(object):
    def __init__(self, a, b):
        assert(a < b)
        self.seen_values = []
        self.computed_matches = {}
        self.append(a)
        self.append(b)

    def append(self, x):
        for y in self.seen_values:
            if x + y not in self.computed_matches:
                self.computed_matches[x + y] = 0
            self.computed_matches[x + y] += 1
        self.seen_values.append(x)

    def compute(self, k):
        if self.seen_values[0] == 2 and self.seen_values[1] > 3 and self.seen_values[1] % 2 == 1 and k > self.get_period_start():
            return self.compute_from_period(k)
        else:
            return self.compute_from_sieve(k)

    def compute_from_sieve(self, k):
        candidate = self.seen_values[-1]
        while len(self.seen_values) < k:
            candidate += 1
            if candidate in self.computed_matches and self.computed_matches[candidate] == 1:
                self.append(candidate)
        return self.seen_values[k - 1]

    def compute_from_period(self, k):
        assert(k > self.get_period_start())
        period = self.get_period()
        fundamental_difference = sum(period)
        base = self.compute_from_sieve(self.get_period_start()) + fundamental_difference*((k - self.get_period_start())/len(period))
        return base + sum(period[0:(k - self.get_period_start())%len(period)])

    def get_period(self):
        if not hasattr(self, 'period'):
            self.period = self.compute_period()
        return self.period

    def compute_period(self):
        assert(self.seen_values[0] == 2)
        diffs = self.compute_diffs(self.get_period_start(), self.get_period_start() + self.get_period_sample_size())

        period_found = False
        period_length = 1
        while not period_found and period_length < len(diffs):
            period = diffs[0:period_length]
            period_found = True
            i = period_length
            while i < len(diffs):
                upper_index = i + period_length
                if upper_index < len(diffs) and period != diffs[i:upper_index]:
                    period_found = False
                i += period_length
            period_length += 1
        if not period_found:
            raise "Period not found"
        return period

    def compute_diffs(self, start, end):
        diffs = []
        previous = self.compute_from_sieve(start)
        for k in range(start + 1, end + 1):
            s = self.compute_from_sieve(k)
            diffs.append(s - previous)
            previous = s
        return diffs

    def get_period_start(self):
        return 1000

    def get_period_sample_size(self):
        return 5000

class UTest(unittest.TestCase):
    def test_sieve(self):
        for (k, u) in [(1, 1), (2, 2), (3, 3), (4, 4), (5, 6), (6, 8), (7, 11)]:
            self.assertEquals(U(1, 2).compute(k), u)

    def test_period(self):
        for n in range(2, 11):
            v = 2*n + 1
            u = U(2, v)
            for k in [u.get_period_start() + 1, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000]:
                self.assertEquals(u.compute_from_sieve(k), u.compute_from_period(k), "v: " + str(v) + " k: " + str(k))

    def test_large_values(self):
        u = U(2, 5)
        self.assertEquals(u.compute_from_period(10**11), 393749999981)

# if __name__ == '__main__':
#     unittest.main()

result = 0
for n in range(2, 11):
    v = 2*n + 1
    u = U(2, v)
    x = u.compute(10**11)
    print str(v) + ": " + str(x)
    print len(u.get_period())
    result += x
print result
