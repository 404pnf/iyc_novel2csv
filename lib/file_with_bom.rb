# -*- coding: utf-8 -*-
def file_with_bom file
  # excel不认识utf-8的csv文件，必须加不合规范的BOM头
  # 参考： http://stackoverflow.com/questions/155097/microsoft-excel-mangles-diacritics-in-csv-files
  File.open(file, 'w')do |f|
    f.puts  "\uFEFF"
  end
end
