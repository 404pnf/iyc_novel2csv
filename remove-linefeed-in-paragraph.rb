# -*- coding: utf-8 -*-
require './lib/class.rb'
require 'find'
require 'fileutils'
$input = File.expand_path(ARGV[0])
$output = File.expand_path(ARGV[1])

def r_rm_line_feed(input, output)
  # expand input out path first, or else
  # e.g input is 'user', output if 'other'
  # /home/user/user will be replaced as /home/other/user, wrong!
  # should be /home/user/other ya
  # if we expand the path, that won't happen
  input = File.expand_path $input
  output = File.expand_path $output 
  
  Find.find(input) do |file|
    next unless file =~ /txt$/i
    next if File.directory?(file)
#    $inputfile = File.basename(file, 'txt') # $inputfile is filename. , with a dot
    $inputfile = File.basename(file) # $inputfile is filename. , with a dot
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
  ending_msg
end
r_rm_line_feed($input, $output)

str = '''
Splits str using the supplied parameter as the
record separator ($/ by default), passing each 
substring in turn to the supplied block. If a
zero-length record separator is supplied, the
string is split into paragraphs delimited by multiple
successive newlines.


  poem goes from here
  blue fish, red fish
  cool fish, snoop fish


string is split into paragraphs delimited by multiple
string is split into paragraphs delimited by multiple
string is split into paragraphs delimited by multiple

record separator ($/ by default), passing each 
substring in turn to the supplied block. If a
zero-length record separator is supplied, the
string is split into paragraphs delimited by multiple
successive newlines.



'''
File.open('t.txt', 'w') do |f|
  f.puts str.remove_line_feed
end
