# -*- coding: utf-8 -*-
# require './lib/class.rb'
require 'find'
require 'fileutils'
require 'minitest/autorun'
require 'pp'

# usage: ruby -w script.rb inputfolder outputfolder

$input = File.expand_path(ARGV[0])
$output = File.expand_path(ARGV[1])

def r_rm_line_feed(input, output)
  input = File.expand_path $input
  output = File.expand_path $output 
  Find.find(input) do |file|
    next unless file =~ /txt$/i
    next if File.directory?(file)
    $inputfile = File.basename(file) # $inputfile is filename with suffix
    $inputpath = File.dirname(file)
    $newpath = $inputpath.sub(input, output)
    FileUtils.mkdir_p $newpath unless File.exist? $newpath
    text = File.read(file)
    newtext = text.remove_line_feed
    puts "正在处理： #{file}"
    puts ""
    File.open("#{$newpath}/#{$inputfile}", "w") do |f|
      f.puts newtext
    end
  end
  puts "\nYour documents are ready at #{output}!\n\n\n"
end
r_rm_line_feed($input, $output)

class String
  def remove_line_feed
    text = 
      self.sub(/^\xef\xbb\xbf/, '') # remove bom
      .gsub(/\r/, '')
      .gsub(/\n\n+/, "\n\n")
    arr = text.split("\n\n")
    arr.map! do |line|
      if line =~ /^\s/ #开头是空白的行不处理 
        line
      else
        line = line.gsub(/\n/, ' ')
      end
    end
    # p arr
    arr.join("\n\n")
  end
end

# tests

UNFORMATED = "111111\n111111\n\n\n   22222\n   22222\n\n\n\n111111\n111111"
FORMATED   = "111111 111111\n\n   22222\n   22222\n\n111111 111111"

class TestSanitize < MiniTest::Unit::TestCase

  def test_remove_line_feed
    assert_equal "111 111\n\n111 111", "111\n111\n\n\n111\n111".remove_line_feed, 'join lines'
    assert_equal "111 111\n\n111 111\n\n222 222 ", "111\n111\n\n\n111\n111\n\n\n222\n222\n".remove_line_feed, 'two, paragraphs, join lines'
    assert_equal " 222\n 222\n 222", " 222\n 222\n 222".remove_line_feed, 'do not join lines pre lines'
    assert_equal " 222\n 222\n\n 222\n 222", " 222\n 222\n\n\n\n\n 222\n 222".remove_line_feed, 'two parts, do not join lines pre lines'
    assert_equal FORMATED, UNFORMATED.remove_line_feed, 'mix paragraph and pre'
  end

end
