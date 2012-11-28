# -*- coding: utf-8 -*-
require './lib/class.rb'
require 'find'
require 'punkt-segmenter'

# ref on sentence split in ruby
# http://stackoverflow.com/questions/860809/how-do-you-parse-a-paragraph-of-text-into-sentences-perferrably-in-ruby
# http://en.wikipedia.org/wiki/Sentence_boundary_disambiguation 
# http://stanfordparser.rubyforge.org/

$input = File.expand_path(ARGV[0])
$output = File.expand_path(ARGV[1])
def t2c(file)
  # http://stackoverflow.com/questions/9886705/how-to-write-bom-marker-to-a-file-in-ruby
  # ruby 1.9.2 accepts r:bom|utf-8 and automatcially removes BOM
  File.open(file, 'r:bom|utf-8') do |f| 
    text = f.read
    text = text.sub(/^\s+/, '')
    text = text.gsub(/\r/, '')
    #    text = text.gsub(/^\s+/, '')
    LINESEPARATOR = i-am-the-line-separator-biyatch
    text = text.gsub(/\n\n/, 'i-am-the-line-separator-biyatch')
    text = text.gsub(/\n/, " ")
#    text = text.gsub( 'i-am-the-line-separator-biyatch', "\n\n")
#    arr = text.split(/\n\n/) # split text by paragraph
    text.each(LINESEPARATOR) do |para|
    arr.reject! {|i| i == ''}
    # p arr.size
    result = []
    arr.map! do |item|
      tokenizer = Punkt::SentenceTokenizer.new(item)
      result    = tokenizer.sentences_from_text(item, :output => :sentences_text)
      # result is an array
      item = result
      item.map! {|i| i.gsub(/\r/, "\n")}
      item.map! {|i| i.gsub(/\n+/, ' ')} # there are \r\n within sentences 
      #     item.join(' ')
      #    file_with_bom
      #    write_yaml(input.txt2arr)
      #pp item
    end
    
    write_yaml(arr)
    pp arr
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
