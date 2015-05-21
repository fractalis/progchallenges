require 'test/unit'
require 'test/unit/ui/console/testrunner'

def simplify(arr)
  return [] unless arr.is_a? Array
  uniq_h = Hash.new
  arr.select { |x| (uniq_h.has_key?(x) or not x.is_a? Integer) ? false : (uniq_h[x] = x and true) }
     .sort
  end

class TestSimplify < Test::Unit::TestCase
      def setup(); end
      def teardown(); end

      def test_returns_sorted
        assert_equal(simplify([9,4,1]), [1,4,9])
        assert_equal(simplify([5,4,0,-1]), [-1,0,4,5])
      end

      def test_returns_uniq_and_sorted
        assert_equal(simplify([0,9,8,3,3,3,5,9,5,0]), [0,3,5,8,9])
        assert_equal(simplify([1,1,1,1,1,1]), [1])
      end

      def test_empty_array
        assert_equal(simplify([]), [])
      end

      def test_returns_empty_array_with_invalid_input
        assert_equal(simplify("abc"), [])
      end

      def test_filters_out_invalid_input_in_array
        assert_equal(simplify([0,4,4,3,"a"]), [0,3,4])
      end

end

