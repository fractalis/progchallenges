require 'test/unit'
require 'test/unit/ui/console/testrunner'

def findWord(query, array_of_strings)
  endarray = array_of_strings.select { |x| x.downcase.index(query.downcase) }
  return endarray.empty? ? ["Empty"] : endarray
end

class PartialWordTest < Test::Unit::TestCase

  def setup
  end

  def teardown
  end

  def test_empty_array_returns_empty
    assert_equal(findWord("foobar", []), ["Empty"])
  end

  def test_query_of_empty_string_returns_array
    assert_equal(findWord("", ["baz", "bar"]), ["baz", "bar"])
  end

  def test_query_with_foo_against_array_with_foo_returns_array_foo
    assert_equal(findWord("foo", ["foo"]), ["foo"])
  end

  def test_query_has_spaces_matches_array
    assert_equal(findWord("foo bar", ["foo", "bar", "foo bar"]), ["foo bar"])
  end

  def test_substring_query_matches_array
    assert_equal(findWord("az", ["foo", "bar", "baz", "taz"]), ["baz", "taz"])
  end

  def test_allcap_query_matches_lowercase_array
    assert_equal(findWord("UAR", ["guardian", "maiden"]), ["guardian"])
  end

  def test_downcase_query_matches_uppercase_array
    assert_equal(findWord("uar", ["GUARDIAN", "MAIDEN"]), ["GUARDIAN"])
  end
end

