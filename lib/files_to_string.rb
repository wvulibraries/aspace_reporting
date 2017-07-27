# This loops through an sql directory
# and creates and array to map to varaibles 
# so we can avoid long ugly strings in the ruby code.
#
# Author::    David J. Davis (djdavis@mail.wvu.edu)

# Gets the files from the directory
# reads the contents and sends it back as an array 
class FilesToArray
  attr_accessor :dir
  
  # sets directory 
  # *Params*: 
  # - +dir+ -> the directory the files are in (MUST BE A DIRECTORY OBJECT)
  def initialize (dir)
    @dir = dir
  end

  # create a variable array so that you can set the variables
  # *Returns*: 
  # array of file strings from file_content
  def set_array_values
    temp = []
    @dir.each { |file_name|
      next if File.directory? file_name
      temp << get_file_contents(file_name)
    }
    temp
  end

  # gets the file contents of given file
  # *Params*: 
  # - +file+ -> the file your getting the contents of 
  # *Returns*: 
  # - +contents+ -> the string of the file contents 
  def get_file_contents(file)
    o_file = File.open(file, "rb")
    contents = o_file.read
  end 
end  