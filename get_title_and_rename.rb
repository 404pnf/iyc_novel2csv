# -*- coding: utf-8 -*-
require 'find'
require 'fileutils'

path = File.expand_path ARGV[0]

Find.find(path) do |file|
  next if File.directory? file
  next unless file =~ /.txt$/i
  filepath = File.dirname file
#  p filepath
  filename = File.basename(file, '.txt')
 # p filename
  File.open(file, 'r') do |l|
    title = l.gets
    # The (?:…) construct provides grouping without capturing.
    if m = title.match(/The Project Gutenberg (?:EBook|etext) of(.+)/i)
      $title = m[1].to_s.sub(/^ /, '').downcase.tr(',;:', '').gsub(/ /, '_').gsub(/\n|\r/, '')
    else
      $title = ''
    end
#    p $title
  end
  newfilename = filename.downcase + '_' + $title + '.txt'
  newfilename = newfilename.gsub(/_+\./, '.') # handle "An_Essay_on_Profits_.txt"
  #p newfilename
 # p "rename #{filename} to #{newfilename}"
#  p filepath
 # p file
  FileUtils.mv(file, "#{filepath}/#{newfilename}") # do NOT separate path and filename with '/', filepath has the ending slash already
end

