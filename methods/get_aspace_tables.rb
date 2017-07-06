def get_aspace_tables 
  file = './aspace_tables/tables.csv'

  unless File.file?(file)
    abort('No file for tables found')
  end 

  o_file = File.open(file, "rb")
  contents = o_file.read
  contents.split(',')
end 