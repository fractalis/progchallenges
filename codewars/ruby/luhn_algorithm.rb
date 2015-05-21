=begin

In this Kata, you will implement The Luhn Algorithm, which is used to help validate credit card numbers.

Given a positive integer of up to 16 digits, return true if it is a valid credit card number, and false if it is not.

Here is the algorithm:

1) If there are an even number of digits, double every other digit starting with the first, and if there are an odd number of digits, double every other digit starting with the second. Another way to think about it is, from the right to left, double every other digit starting with the second to last digit.

2) If a resulting doubled number is greater than 9, replace it with either the sum of it's own digits, or 9 subtracted from it.

3) Sum all of the final digits

4) Finally, take that sum and divide it by 10. If the remainder equals zero, the original credit card number is valid.
=end

require 'test/unit'
require 'test/unit/ui/console/testrunner'


def validate(n)
  return false if n > 9999999999999999 or n < 0

  sum = n.to_s.split('')
         .map(&:to_i).reverse
         .each_with_index.map { |x,i| i%2 == 0 ? x : ((x*2 > 9) ? (x*2-9) : x*2) }
         .reduce(&:+)
  sum%10 == 0
end

class TestLuhnAlgorithm < Test::Unit::TestCase
  def setup(); end
  def teardown(); end
  
  def test_validate_handles_incorrect_inputs
    assert_equal(validate(10000000000000000), false)
    assert_equal(validate(-1), false)
  end

  def test_validate_does_not_accept_invalid_credit_card_numbers
    assert_equal(validate(891), false)
    assert_equal(validate(1234), false)
    assert_equal(validate(12345), false)
    assert_equal(validate(1714), false)
  end

  def test_validate_accepts_valid_credit_card_numbers
    assert_equal(validate(378282246310005), true)
    assert_equal(validate(4222222222222), true)
  end
end
