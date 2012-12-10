# -*- coding: utf-8 -*-
require 'csv'
require 'test/unit'

# USAGE: ruby script.rb file1 file2 output-csv
# iterate each line of input files
# combine each line to a csv file

$file1 = File.expand_path ARGV[0]
$file2 = File.expand_path ARGV[1]
$output = File.expand_path ARGV[2]
def check_if_same_size arr1, arr2
  return arr1.size == arr2.size
end
def combine_two_arrays arr1, arr2
  # use Array#zip, it's cool
  arr1.zip arr2
end
def combine_files_to_csv file1, file2, output
  file1, file2, output = $file1, $file2, $output
  arr1, arr2 = File.read(file1).split, File.read(file2).split
  return 'Check line numbers of two files! They are not equal!' unless check_if_same_size arr1.size, arr2.size
  csv_arr = arr1.zip arr2
  CSV.open($output, 'w', {:force_quotes=>true}) do |row|
    csv_arr.each {|i| row << i}
  end
  csv_arr
end
combine_files_to_csv $file1, $file2, $output unless $file1 == nil  

# test
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
  EXPECTED = [["1", "a"], ["2", "b"], ["3", "c"]]
  def test_combine_files_to_csv 
    assert_equal EXPECTED, combine_files_to_csv(A,B, nil)
  end
end
=begin
# I was young and re-inventing the wheels
# I didn't know there was zip
# I knew it but didn't realize I can use it here
def combine_text_to_csv (arr1, arr2)
  # 相同index元素会对齐到csv中
  # input: two arrays
  # output: an array
  r = []
  0.upto(arr1.size-1) do |n|
    r << [arr1[n], arr2[n]]
  end
  r
end
combine_text_to_csv $file1, $file2, $output unless $file1 == nil
=end
