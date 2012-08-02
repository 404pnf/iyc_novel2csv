# -*- coding: utf-8 -*-
require 'csv'
require 'fileutils'
require 'yaml'
require 'pp'

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
  File.open("#{$newpath}/#{$inputfile}txt", 'w')do |f|
#    f.puts  "\uFEFF"
  end
end
def write_yaml(arr)
  FileUtils.mkdir_p("#{$newpath}") unless File.exist?("#{$newpath}")
  hash = Hash.new {|h, k| h[k] = []}
  arr.each_with_index do |item,index| 
    key = sprintf("%06d", index )
    hash[key] = [item]
    hash[key] << 'zh_CN'
  end
  text = hash.to_yaml
  File.open("#{$newpath}/#{$inputfile}txt", 'a', ) do |file|  # append mode
    file.puts  text
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

