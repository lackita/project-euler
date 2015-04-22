import sys
import unittest

def U(a, b, k):
    if k == 1:
        return [a]
    elif k == 2:
        return [b]
    elif k == 3:
        return U(a, b, 1) + U(a, b, 2)
    elif k == 4:
        return U(a, b, 1) + U(a, b, 3)
    elif k == 5:
        return U(a, b, 2) + U(a, b, 4)
    elif k == 6:
        return U(a, b, 2) + U(a, b, 5)
    elif k == 7:
        return U(a, b, 3) + U(a, b, 6)

# print U(1, 2, int(sys.argv[1]))

class VerifyExampleTest(unittest.TestCase):
    def test_values(self):
        for (k, u) in [(1, 1), (2, 2), (3, 3), (4, 4), (5, 6), (6, 8), (7, 11)]:
            self.assertEquals(sum(U(1, 2, k)), u)

# unittest.main()
for k in range(1, 8):
    print str(k) + ": " + str(U(1, 2, k))
