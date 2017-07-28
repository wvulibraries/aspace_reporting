require "mysql2"
require 'rubyXL'

class AccessorReport
  attr_accessor :sql_data, :excel_file
  attr_reader :root
  
  def initialize
    @root = File.expand_path('../..', __FILE__)
    @excel_file = "#{@root}/exports/aspace_accessions_report"
  end

  def sql_data=(value)
    if !value.is_a?(Array)
      abort 'data must be an array'
    end 
    @sql_data = value
  end

  def export_directory
    dir_name = "#{@root}/exports" 
    Dir.mkdir(dir_name) unless Dir.exists?(dir_name)
  end

  def create_workbook
    if File.exists?(@excel_file)
      @workbook = RubyXL::Parser.parse(@excel_file)
    else 
      @workbook = RubyXL::Workbook.new
    end 
  end

  def save_workbook
    if @workbook.nil?
      self.create_workbook
    end
    @workbook.write(@excel_file)
  end
end