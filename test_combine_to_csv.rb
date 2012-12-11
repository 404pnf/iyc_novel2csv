# -*- coding: utf-8 -*-
require_relative 'combine_to_csv.rb'
require 'test/unit'

class TestCombineToCsv < Test::Unit::TestCase
  def test_check_if_same_size
    assert_equal true, check_if_same_size([1,2], [3,4]), 'same size'
    assert_equal false, check_if_same_size([1], [3,4]), 'not same size'
  end
  def test_combine_two_arrays
    assert_equal [[1,2], [2,1]], combine_two_arrays([1,2], [2,1]), 'two items'
    assert_equal [[1, 'a'], [2, 'b'],[3, 'c']], combine_two_arrays([1,2,3], ['a','b','c']), 'three items'
  end
  A = [1,2,3]
  B = ['a', 'b', 'c']
  EXPECTED = "\"[1, \"\"a\"\"]\",\"[2, \"\"b\"\"]\",\"[3, \"\"c\"\"]\"\n"
  def test_array_to_csv
    assert_equal EXPECTED, (A.zip B).to_csv
  end
end
