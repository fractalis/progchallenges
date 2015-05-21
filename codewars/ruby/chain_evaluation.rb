=begin

NOTE: This was actually a JS Kata, but here's a Ruby implementation

Method chaining is a very interesting way to keep your program clean.

As a part of this Kata, you need to create functions such that one could evaluate the following expression:

(3).add(5).multiply(2)
The above expression evaluates to be 16.

You need to implement the following methods:

add
subtract
multiply
divide
square
After you're done, one could chain these five methods to create chains of almost any length.

=end

require 'test/unit'
require 'test/unit/ui/console/testrunner'

class Fixnum
  def add(x); self + x; end
  def subtract(x); self - x; end
  def multiply(x); self * x; end
  def divide(x); self / x; end
  def square(); self * self; end
end

class TestFixnumChainEvaluation < Test::Unit::TestCase
  def setup; end;
  def teardown; end;

  def test_adds_numbers()
    assert_equal((3).add(5), 8)
  end

  def test_subtracts_numbers()
    assert_equal((5).subtract(2), 3)
  end

  def test_multiplies_numbers()
    assert_equal((6).multiply(10), 60)
  end

  def test_divides_by_nonzero()
    assert_equal((10).divide(2), 5)
  end

  def test_divide_by_zero_raises_exception()
    assert_raise ZeroDivisionError do
      (1).divide(0)
    end
  end

  def test_square_positive_number()
    assert_equal((5).square(), 25)
  end

  def test_square_negative_number()
    assert_equal((-3).square(), 9)
  end

  def test_chain_methods()
    assert_equal((5).add(10).multiply(3), 45)
    assert_equal((9).subtract(6).square(), 9)
    assert_equal((100).divide(4).divide(5).add(2), 7)
    assert_equal((-10).multiply(5).divide(-10).subtract(5), 0)
  end

end
