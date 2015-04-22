import unittest

class UTest(unittest.TestCase):
    def test_examples(self):
        for (k, u) in [(1, 1), (2, 2), (3, 3), (4, 4), (5, 6), (6, 8), (7, 11)]:
            self.assertEquals(U(1, 2, k), u)

if __name__ == '__main__':
    unittest.main()
