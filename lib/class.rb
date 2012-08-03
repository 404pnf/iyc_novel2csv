# -*- coding: utf-8 -*-
require 'csv'
require 'fileutils'
require 'yaml'
require 'pp'

class String
  def txt2arr
    str = self.gsub(/\r/,'')
    tmp = str.split(/\n\n/)
    arr = tmp.delete_if {|i| i == ''} 
    arr = arr.delete_if {|i| i =~ /^\s$/} 
    arr.map! {|i| i.gsub(/\n/, ' ')}
    arr.map! {|i| i.sub(/^\s+/,'')}
    arr.each {|i| p i =~ /^\s/}
    return arr
  end
  LINESEPARATOR = 'i-am-the-line-separator-and-i-am-so-fine-i-work-all-day-i-sleep-all-night'
  def remove_line_feed
    text = self.gsub(/\r/, '')
    text = text.gsub(/\n\n+/, "\n\n")
    text = text.gsub(/\n\n+/, LINESEPARATOR)
    new = ''
    text.each_line do |l|
      if l =~ /^\s/ #开头是空白的行不处理
        new << l
      else
        new << l.gsub(/\n/, ' ')
      end
    end
    new = new.gsub(LINESEPARATOR, "\n\n")
    return new
  end
end

def file_with_bom
  # excel不认识utf-8的csv文件，必须加不合规范的BOM头
  # 参考： http://stackoverflow.com/questions/155097/microsoft-excel-mangles-diacritics-in-csv-files
  FileUtils.mkdir_p("#{$newpath}") unless File.exist?("#{$newpath}")
#  File.open("#{$newpath}/#{$inputfile}txt", 'w')do |f|
  File.open("#{$newpath}/#{$inputfile}csv", 'w')do |f|
    #    f.puts  "\uFEFF"
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

def write_yaml(arr)
  FileUtils.mkdir_p("#{$newpath}") unless File.exist?("#{$newpath}")
  #  hash = Hash.new {|h, k| h[k] = []}
  hash = Hash.new{|h,k| h[k]=Hash.new(&h.default_proc) } 
  arr.each_with_index do |item,index| 
    key = sprintf("%05d", index )
    item.each_with_index do |i, n|
      hash[key][n] = i
#      hash[key][n] << 'zh_CN'
    end
  end
  text = hash.to_yaml
  #pp text
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

