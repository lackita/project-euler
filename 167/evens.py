import unittest

class U(object):
    def __init__(self, v):
        self.computed_results = {}
        self.k_lookup = []
        self.append(2)
        self.append(v)
        self.compute((v + 7)/2 - 1)
        self.append(self.nontrivial_even())

    def compute(self, k):
        candidate = self.k_lookup[-1] - (self.k_lookup[-1] + 1)%2
        while k > len(self.k_lookup):
            candidate += 2
            if (candidate - 2 in self.computed_results) ^ (candidate - self.nontrivial_even() in self.computed_results):
                print str(len(self.k_lookup)) + ": " + str(candidate)
                self.append(candidate)
        return self.k_lookup[k - 1]

    def append(self, x):
        self.computed_results[x] = True
        self.k_lookup.append(x)

    def nontrivial_even(self):
        return 2*self.k_lookup[1] + 2

class UTest(unittest.TestCase):
    def test_precomputed(self):
        u = U(5)
        for (k, x) in [(1, 2), (2, 5), (3, 7), (4, 9), (5, 11), (6, 12), (7, 13), (8, 15), (9, 19), (10, 23), (11, 27), (12, 29)]:
            self.assertEquals(u.compute(k), x)

if __name__ == '__main__':
    unittest.main()
