# -*- coding: utf-8 -*-
require 'find'
require 'fileutils'

# !! update filename in place !!
# usage: ruby -w script.rb inputfolder
# files in inputfolder will be renamed accordingly

path = File.expand_path ARGV[0]

Find.find(path) do |file|
  next if File.directory? file
  next unless file =~ /.txt$/i
  filepath = File.dirname file
  filename = File.basename(file, '.txt')
  File.open(file, 'r') do |l|
    title = l.gets
    # The (?:…) construct provides grouping without capturing.
    #if m = title.match(/The Project Gutenberg (?:EBook|etext) of(.+)/i)
    $realtitle = title.split(':')[1] # first line is titile, format,  title: this is title

    if $realtitle
      $realtitle = $realtitle.strip.tr(',;:', '').gsub(/\s+/, '_').gsub(/\n|\r/, '').downcase
    else
      $realtitle = ''
    end
  end
#    p $realtitle
  p filepath
  newfilename = filename.downcase + '_' + $realtitle + '.txt'
  newfilename = newfilename.gsub(/_+\./, '.') # handle "An_Essay_on_Profits_.txt"
  p "rename #{filename} to #{newfilename}"
  if filename + '.txt' != newfilename
    FileUtils.mv(file, "#{filepath}/#{newfilename}") 
  end # can't get title for some files so newfilename would be equal to filename, skip those!
end

