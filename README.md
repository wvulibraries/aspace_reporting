# Archivesspace Report Script  

This script runs through variety of data linked accession objects in archivesspace.  It does this using SQL and Ruby to format the item into excel spreadsheets.  This script was written for a yearly use and getting items out that were needed for Libraries reporting.

## Dependencies  
- Archivesspace >= 2.0.1 
- Ruby >= 2.3.3  

## GEMS  
- Mysql2 
- RubyXL 

## How to Use
 refer to the init.rb file 
 
 ```
 #!/usr/bin/env ruby

# gems 
require 'mysql2'
require 'rubyXL'

# require lib folder
Dir['./lib/*.rb'].each {|file| require file }

# set the root as a constant global
root = File.dirname(__FILE__) 
sql_file = FileHelper.new("#{root}/sql/accessions.sql")
sql = sql_file.get_file_contents.to_s

# connect to db 
@db = Database.new
sql_data = @db.query(sql).to_a

# generate report 
report = AccessorReport.new
report.excel_file = "#{root}/exports/report.xlsx"
report.create_workbook
report.sql_data = sql_data
report.write_to_workbook
report.write_headers
report.save_workbook

puts "Everything worked congrats!"
``` 

## Contributing 
This can be done in the form of documentation, code, or submitting bugs.  

If you notice a way to improve this code, or want contribute your work back to the repository.  You may do so by forking the repository and putting in a pull-request with changes you have made.   

## Open Source 
This is open source, you can copy, read, modify, fork, etc without telling the West Virginia University Library.  The various gems, programming languages, and other depdendencies may have other liscensing.  