import unittest
from pq import U
from period import Period

class UlamTest(unittest.TestCase):
    def test_precomputed(self):
        u = U(5)
        for (k, x) in [(1, 2), (2, 5), (3, 7), (4, 9), (5, 11), (6, 12), (7, 13), (8, 15), (9, 19), (10, 23), (11, 27), (12, 29)]:
            self.assertEquals(u.compute(k), x)

    def test_period(self):
        for n in range(2, 5):
            v = 2*n + 1
            u = U(v)
            p = Period(u, 100)
            ks = [500*x + 500 for x in range(1, 20)]
            ks.append(p.period_start + 1)
            for k in ks:
                self.assertEquals(u.compute(k), p.compute(k), "v: " + str(v) + " k: " + str(k))

    def test_large_values(self):
        self.assertEquals(Period(U(5), 100).compute(10**11), 393749999981)
        self.assertEquals(Period(U(7), 100).compute(10**11), 484615384605)
        self.assertEquals(Period(U(9), 100).compute(10**11), 400450450395)
        self.assertEquals(Period(U(11), 100).compute(10**11), 399877149781)
        self.assertEquals(Period(U(13), 100).compute(10**11), 399966136001)
        self.assertEquals(Period(U(15), 100).compute(10**11), 637499999951)
        self.assertEquals(Period(U(17), 100).compute(10**11), 400001574629)
        self.assertEquals(Period(U(19), 100).compute(10**11), 399999473477)
        self.assertEquals(Period(U(21), 100).compute(10**11), 399999900065)

if __name__ == '__main__':
    unittest.main()
