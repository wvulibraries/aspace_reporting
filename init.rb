#!/usr/bin/env ruby

# gems 
require 'mysql2'
require 'rubyXL'

# require lib folder
Dir['./lib/*.rb'].each {|file| require file }

# set the root as a constant global
root = File.dirname(__FILE__) 
sql_file = FileHelper.new("#{root}/sql/accessions_report.sql")
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