# -*- coding: utf-8 -*-
require 'find'
require 'fileutils'
require 'minitest/autorun'

# USAGE: ruby -w script.rb inputfolder 
# !! update filename in place !!
# files in inputfolder will be renamed accordingly

path = File.expand_path ARGV[0]

Find.find(path) do |file|
  next if File.directory? file
  next unless file =~ /.txt$/i
  filepath = File.dirname file
  filename = File.basename(file, '.txt')
  File.open(file, 'r') do |l|
    title = l.gets # 默认第一行就是题目 且题目格式是 title: some title
    # The (?:…) construct provides grouping without capturing.
    #if m = title.match(/The Project Gutenberg (?:EBook|etext) of(.+)/i)
    $realtitle = title.iyc_get_title
    if $realtitle # 也许有的文件就没有 title: some title 这行 必须得确认 #realtitle 不是 nil
      $realtitle = $realtitle.strip.tr(',;:', '').gsub(/\s+/, '_').gsub(/\n|\r/, '').downcase
    else
      $realtitle = '' 
    end
  end
  newfilename = filename.downcase + '_' + $realtitle + '.txt'
  newfilename = newfilename.gsub(/_+\./, '.') # handle "An_Essay_on_Profits_.txt"
  p "rename #{filename} to #{newfilename}"
  if filename + '.txt' != newfilename  # 如果将文件改名为它自身会报错，比如 mv file file 报错的
    FileUtils.mv(file, "#{filepath}/#{newfilename}") 
  end # can't get title for some files so newfilename would be equal to filename, skip those!
end

class String
  def iyc_get_title
    self.split(':')[1..-1].join.strip
    # array[1..-1] to cater to special case Title: title with colon: a true story
  end
  def iyc_title_to_filename
    self.strip.tr(',;:!', '').gsub(/\s+/, '_').gsub(/\n|\r/, '').downcase
  end
end

# tests

class TestSanitize < MiniTest::Unit::TestCase
  def test_iyc_get_title
    assert_equal 'The History Of The Decline And Fall Of The Roman Empire', 'Title: The History Of The Decline And Fall Of The Roman Empire'.iyc_get_title, 'test case 1'
    assert_equal 'Les Miserables', 'Title: Les Miserables'.iyc_get_title, 'test case 2'
  end
  def test_iyc_title_to_filename
    assert_equal 'some_strange_characters', 'Title: some; strange: characters!'.iyc_get_title.iyc_title_to_filename, 'test case 3'
  end
end
