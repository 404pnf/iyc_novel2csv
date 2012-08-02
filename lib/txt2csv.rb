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

def file_with_bom
  # excel不认识utf-8的csv文件，必须加不合规范的BOM头
  # 参考： http://stackoverflow.com/questions/155097/microsoft-excel-mangles-diacritics-in-csv-files
  FileUtils.mkdir_p("#{$newpath}") unless File.exist?("#{$newpath}")
  File.open("#{$newpath}/#{$inputfile}csv", 'w')do |f|
    f.puts  "\uFEFF"
  end
end
def write_csv(arr)
  # 悲剧，ruby的csv默认就是不quote值，浪费了半个小时才找到:force_quote用法
  # http://stackoverflow.com/questions/5831366/quote-all-fields-in-csv-output
  CSV.open("#{$newpath}/#{$inputfile}csv", 'a', {:force_quotes=>true}) do |csv|  # append mode
    arr.each do |paragraph| 
      csv << [paragraph]
    end
  end
end
def ending_msg
  puts "========================================="
  puts "da di di da da"
  puts ''
  puts "都转好了，请查看 #{File.expand_path $output} 目录。"
  puts ''
  puts '========================================='
end

