# -*- coding: utf-8 -*-
# require './lib/class.rb'
require 'find'
require 'fileutils'
require 'minitest/autorun'
require 'pp'

# usage: ruby -w script.rb inputfolder outputfolder

$input = File.expand_path(ARGV[0])  if __FILE__ == $0
$output = File.expand_path(ARGV[1]) if __FILE__ == $0

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
r_rm_line_feed($input, $output) if __FILE__ == $0

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

