class FileHelper
  attr_accessor :file_path 
  
  # sets directory 
  # *Params*: 
  # - +dir+ -> the directory the files are in (MUST BE A DIRECTORY OBJECT)
  def initialize (file_path)
    @file_path = file_path 
  end

  # gets the file contents of given file
  # *Params*: 
  # - +file+ -> the file your getting the contents of 
  # *Returns*: 
  # - +contents+ -> the string of the file contents 
  def get_file_contents
    o_file = File.open(file_path, "rb")
    contents = o_file.read
  end 
end  