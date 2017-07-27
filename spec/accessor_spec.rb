require 'accessor_report'

describe AccessorReport do
  describe 'attributes' do
    it 'allows reading and writing of sql calls' do
      subject.sql_call = "SELECT * FROM `test`;"
      expect(subject.sql_call).to eq("SELECT * FROM `test`;")
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
    it 'creates creates a workbook' do
      expect(subject.create_workbook).not_to be_nil
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