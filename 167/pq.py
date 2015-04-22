import unittest
from Queue import PriorityQueue

class U(object):
    def __init__(self, v):
        self.computed = []
        self.candidates = PriorityQueue()
        self.candidates.put(2)
        self.candidates.put(v)
        self.candidates.put(2*v + 2)

    def compute(self, k):
        while len(self.computed) < k:
            candidate = self.candidates.get()
            valid = True
            while not self.candidates.empty() and self.candidates.queue[0] == candidate:
                valid = False
                self.candidates.get()
            if valid:
                self.computed.append(candidate)
                if candidate % 2 == 1:
                    self.candidates.put(2 + candidate)
                    self.candidates.put(2*self.computed[1] + 2 + candidate)
        return self.computed[k - 1]


class UTest(unittest.TestCase):
    def test_precomputed(self):
        u = U(5)
        for (k, x) in [(1, 2), (2, 5), (3, 7), (4, 9), (5, 11), (6, 12), (7, 13), (8, 15), (9, 19), (10, 23), (11, 27), (12, 29)]:
            self.assertEquals(u.compute(k), x)

if __name__ == '__main__':
    unittest.main()
