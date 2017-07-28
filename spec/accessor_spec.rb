require 'accessor_report'

describe AccessorReport do
  describe 'attributes' do
    it 'allows reading and writing of sql data' do
        subject.sql_data = ['data', 'stuff']
        expect(subject.sql_data).to eq(['data', 'stuff'])
    end

    it 'expects sql data to be an array' do
      begin
        subject.sql_data = "some string"
        expect(subject.sql_data).to raise_error(SystemExit)
      rescue SystemExit => exit_status
        expect(exit_status.status).to eq 1
      end
    end 

    it 'allows reading and writing of the excel filename' do
      subject.excel_file = 'test.xlsx'
      expect(subject.excel_file).to eq('test.xlsx')
    end
  end 

  describe '.export_directory' do
    it 'can read and knows where the directory root is located' do
      expect(subject.root).to eq(ROOT)
    end 

    it 'creates the export directory if one does not exist' do
      subject.export_directory
      expect(Dir.exists?("#{ROOT}/exports")).to eq(true)
    end
  end

  describe '.create_workbook' do
    it 'creates creates a workbook and sets as instance variable' do
      expect(subject.create_workbook).not_to be_nil
    end
  end

  describe '.save_workbook' do
    it 'saves the created workbook' do
      subject.excel_file = "#{ROOT}/exports/test.xlsx"
      subject.create_workbook 
      subject.save_workbook
      check_file = File.exists? "#{ROOT}/exports/test.xlsx"
      expect(check_file).to eq(true)
    end

    it 'creates a workbook if one does not exist and then saves it' do
      file_path = "#{ROOT}/exports/test.xlsx" 
      File.delete(file_path) # remove any old ones prior to this test
      subject.excel_file = "#{ROOT}/exports/test.xlsx"
      subject.save_workbook
      check_file = File.exists? "#{ROOT}/exports/test.xlsx"
    end
  end

 ## KEY FEATURES OF THE APP
 ## connects to a database
 ## gets data via SQL call 
 ## creates a new excel document or opens an existing one 
 ## creates a page in the excel document 
 ## writes the data to the excel page in the sql document 
 ## creates the custom report

end 