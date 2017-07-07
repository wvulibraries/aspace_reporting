#!/usr/bin/env ruby

# include gems used 
require "mysql2"
require 'rubyXL'

# require all helper files and classes 
Dir["./includes/*.rb"].each {|file| require file }
Dir["./methods/*.rb"].each {|file| require file }

# create a db connection and query some results 
db = DBConnect.new

# test getting tables array 
@tables = get_aspace_tables
@workbook = RubyXL::Workbook.new

num_completed = 0 
# create a spreadsheet for each table
@tables.each do |table_name|
  # SQL Statments 
  sql_statement = "SELECT * FROM `#{table_name}`"
  sql_results = db.query(sql_statement).to_a

  # check to make sure theirs results 
  next if sql_results.length < 1 

  # create a new worksheet 
  tmp_worksheet = @workbook.add_worksheet(table_name)

  # change the style of the worksheet
  tmp_worksheet.change_row_height(0, 80)
  tmp_worksheet.change_row_fill(0, 'eeeeee')

  # put the data in columns and rows
  puts "Writing excel records for #{table_name}"
  sql_results.each_with_index do |row_data, row_number|
    tmp_worksheet.change_row_height(row_number, 30)
    # zebra stripe 
    if row_number.even?
      tmp_worksheet.change_row_fill(row_number, 'eeeeee')
    end
    # row data and cell data
    row_data.values.each_with_index do |cell_data, cell_number| 
      tmp_worksheet.insert_cell(row_number, cell_number, cell_data)
    end
  end

  # column headers 
  headers = sql_results.first.keys
  headers.each_with_index do |value, col_number| 
    tmp_worksheet.insert_cell(0, col_number, value).change_font_color('ffffff')
    tmp_worksheet.change_row_fill(0, '333333')
  end

  @workbook.write("./all_aspace_data.xlsx")
  puts "Saved records for #{table_name} "
  num_completed += 1 
end

puts "All done!"