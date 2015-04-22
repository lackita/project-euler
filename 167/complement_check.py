import unittest

def U(a, b, k):
    assert(a < b)
    if k == 1:
        return a
    if k == 2:
        return b

    seen_values = [a, b]
    value_lookup = {
        a: True,
        b: True,
    }


    candidate = b + 1
    while len(seen_values) < k:
        i = 0
        matches = 0
        while candidate - seen_values[i] > seen_values[i]:
            if candidate - seen_values[i] in value_lookup:
                matches += 1
            i += 1
        if matches == 1:
            seen_values.append(candidate)
            value_lookup[candidate] = True
        candidate += 1
    return seen_values[k - 1]

class UTest(unittest.TestCase):
    def test_examples(self):
        for (k, u) in [(1, 1), (2, 2), (3, 3), (4, 4), (5, 6), (6, 8), (7, 11)]:
            self.assertEquals(U(1, 2, k), u)

if __name__ == '__main__':
    unittest.main()
