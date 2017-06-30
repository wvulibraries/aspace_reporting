#!/usr/bin/env ruby

# include gems used 
require "mysql2"
require 'rubyXL'

# require all helper files and classes 
Dir["./includes/*.rb"].each {|file| require file }
Dir["./methods/*.rb"].each {|file| require file }

# create a db connection and query some results 
db = DBConnect.new()

# Get SQL to make the queries 
# May have to change if you modify the script or add SQL files 
sql_dir = Dir['./sql/*.sql'] 
get_sql_vars = FilesToArray.new(sql_dir)
sql_array = get_sql_vars.set_array_values
get_accessions, get_agents = sql_array 

# accessions 
accessions = []
db.query(get_accessions).each do |row|
  accessions << row
end

# agents 
agents = []
db.query(get_agents).each do |row| 
  agents << row 
end

# workbook 
workbook = RubyXL::Workbook.new

# get first sheet and rename it 
worksheet_temp = workbook[0]
worksheet_temp.sheet_name = 'accessions'

# get the accessions sheet and do stuff with it
accession_sheet = workbook['accessions']
accession_sheet.change_row_height(0, 80)
accession_sheet.change_row_fill(0, 'eeeeee')

accessions.each_with_index do |row_data, row_number|
  accession_sheet.change_row_height(row_number, 30)

  if row_number.even?
    accession_sheet.change_row_fill(row_number, 'eeeeee')
  end

  row_data.values.each_with_index do |cell_data, cell_number| 
    accession_sheet.insert_cell(row_number, cell_number, cell_data)
  end
end

# column headers 
headers = accessions.first.keys
headers.each_with_index do |value, col_number| 
  accession_sheet.insert_cell(0, col_number, value).change_font_color('ffffff')
  accession_sheet.change_row_fill(0, '000000')
end 

# create new agents worksheet
agents_worksheet = workbook.add_worksheet('agents') 
agents.each_with_index do |row_data, row_number|
  agents_worksheet.change_row_height(row_number, 30)

  if row_number.even?
    agents_worksheet.change_row_fill(row_number, 'eeeeee')
  end

  row_data.values.each_with_index do |cell_data, cell_number| 
    agents_worksheet.insert_cell(row_number, cell_number, cell_data)
  end
end

# column headers 
agent_headers = agents.first.keys
agent_headers.each_with_index do |value, col_number| 
  agents_worksheet.insert_cell(0, col_number, value).change_font_color('ffffff')
  agents_worksheet.change_row_fill(0, '000000')
end 

# save it
workbook.write("./archivesspace_report.xlsx")