# -*- coding: utf-8 -*-
require './lib/txt2csv.rb'
require 'find'

$input = File.expand_path(ARGV[0])
$output = File.expand_path(ARGV[1])
def t2c(file)
  File.open(file, 'r:bom|utf-8') do |f| # ruby 1.9.2 accepts r:bom|utf-8 and automatcially removes BOM
    input = f.read
    file_with_bom
    write_csv(input.txt2arr)
  end
end
def r_t2c(input, output)
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
    $inputfile = File.basename(file, 'txt') # $inputfile is filename. , with a dot
    $inputpath = File.dirname(file)
    $newpath = $inputpath.sub(input, output)
    puts "正在处理： #{file}"
    puts ""
    t2c(file) # defined in lib/script2csv.rb
  end
  ending_msg
end
r_t2c($input, $output)