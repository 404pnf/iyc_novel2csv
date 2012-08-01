# -*- coding: utf-8 -*-
require 'csv'
require 'fileutils'

class String

  def txt2arr
    str = self.gsub(/\r/,'')
    tmp = str.split(/\n\n/)
    arr = tmp.reject {|i| i == ''} 
    newarr  = []
    arr.each {|i| newarr << i.gsub(/\n/, ' ')}
    return newarr
  end

end


def write_csv(arr)
  # 悲剧，ruby的csv默认就是不quote值，浪费了半个小时才找到:force_quote用法
  # http://stackoverflow.com/questions/5831366/quote-all-fields-in-csv-output
#  CSV.open("#{$newpath}/#{$inputfile}csv", 'w', {:force_quotes=>true}) do |csv| 
  CSV.open("#{$input}.csv", 'w', {:force_quotes=>true}) do |csv| 
    arr.each do |paragraph| 
      csv << [paragraph]
    end
  end
end

$input = File.basename(ARGV[0])
input = File.read(ARGV[0])
write_csv(input.txt2arr)

