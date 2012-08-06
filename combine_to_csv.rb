# -*- coding: utf-8 -*-
require 'csv'

a = (1..10).to_a
b = 10.downto(1).to_a

# 相同index元素会对齐到csv中
CSV.open('test.csv', 'w', {:force_quotes=>true}) do |row|
  0.upto(a.size-1) do |n|
    row << [a[n], b[n]]
  end
end

# test.csv would be
=begin
1,10
2,9
3,8
4,7
5,6
6,5
7,4
8,3
9,2
10,1
=end


