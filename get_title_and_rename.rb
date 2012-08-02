# -*- coding: utf-8 -*-
require 'find'
require 'fileutils'

path = File.expand_path ARGV[0]

Find.find(path) do |file|
  next if File.directory? file
  next unless file =~ /.txt$/i
  filepath = File.dirname file
  filename = File.basename(file, '.txt')
  File.open(file, 'r') do |l|
    title = l.gets
    # The (?:…) construct provides grouping without capturing.
    if m = title.match(/The Project Gutenberg (?:EBook|etext) of(.+)/i)
      $title = m[1].to_s.sub(/^ /, '').downcase.tr(',;:', '').gsub(/ /, '_').gsub(/\n|\r/, '')
    else
      $title = ''
    end
  end
  newfilename = filename.downcase + '_' + $title + '.txt'
  newfilename = newfilename.gsub(/_+\./, '.') # handle "An_Essay_on_Profits_.txt"
  p "rename #{filename} to #{newfilename}"
  FileUtils.mv(file, "#{filepath}/#{newfilename}") 
end

