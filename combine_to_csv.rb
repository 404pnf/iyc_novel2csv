# -*- coding: utf-8 -*-
require 'csv'
require 'test/unit'

# USAGE: ruby script.rb file1 file2 output-csv
# iterate each line of input files
# combine each line to a csv file

$file1, $file2 = File.expand_path(ARGV[0]), File.expand_path(ARGV[1]) if __FILE__ == $0
$output = File.expand_path(ARGV[2]) if __FILE__ == $0

def check_if_same_size arr1, arr2
  return arr1.size == arr2.size
end
def combine_two_arrays arr1, arr2
  # use Array#zip, it's cool
  arr1.zip arr2
end
def array_to_csv arr
  arr.to_csv
end
# do the real work
def combine_files_to_array
  arr1, arr2 = File.read($file1).split, File.read($file2).split  if __FILE__ == $0
  return 'Check line numbers of two files! They are not equal!' unless check_if_same_size arr1.size, arr2.size
  CSV.open($output, 'w', {:force_quotes=>true}) do |row|
    (arr1.zip arr2).each {|i| row << i}
  end
end
combine_files_to_array if __FILE__ == $0


