"""
Write a method that returns true if a given parameter is a power of 4, and false if it's not.
If parameter is not an Integer (eg String, Array) method should return false as well.
"""
import unittest

def powerof4(n):
    from math import log
    valid_t = [int,float]
    return False if (type(n) not in valid_t or n < 0) else log(n,4).is_integer()

class TestPowerOf4(unittest.TestCase):

    def test_negatives_return_false(self):
        self.assertEqual(powerof4(-1), False)

    def test_invalid_types_return_false(self):
        self.assertEqual(powerof4("testing"), False)
        self.assertEqual(powerof4([]), False)

    def test_powers_of_4_return_true(self):
        self.assertEqual(powerof4(1024), True)
        self.assertEqual(powerof4(4), True)
        self.assertEqual(powerof4(16), True)
        self.assertEqual(powerof4(1.0), True)

    def test_nonpowers_of_4_return_false(self):
        self.assertEqual(powerof4(27), False)
        self.assertEqual(powerof4(40), False)

if __name__ == "__main__":
    unittest.main()

