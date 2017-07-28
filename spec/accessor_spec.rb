require 'accessor_report'
require 'rubyXL'

describe AccessorReport do
  describe 'attributes' do
    it 'allows reading of the root directory' do
      expect(subject.root).to eq(ROOT)
    end 

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

    it 'exits because a workbook has not been created' do
      begin
        file_path = "#{ROOT}/exports/test.xlsx" 
          
        if File.exists? file_path 
          File.delete(file_path)
        end 

        subject.excel_file = file_path 
        expect(subject.save_workbook).to raise_error(SystemExit)
      rescue SystemExit => exit_status
        expect(exit_status.status).to eq 1
      end
    end
  end

  describe '.write_to_workbook' do 
    it 'exits because a workbook was not created can not write to a non-existant workbook' do
      begin
        subject.excel_file = "#{ROOT}/exports/test.xlsx"
        subject.sql_data = ['test_header': "test"]; 
        expect(subject.write_to_workbook).to raise_error(SystemExit)
      rescue SystemExit => exit_status
        expect(exit_status.status).to eq 1
      end
    end

    it 'finds the first worksheet and replaces it' do
      subject.excel_file = "#{ROOT}/exports/test.xlsx"
      subject.create_workbook
      subject.sql_data = ['test_header': "test"]; 
      subject.write_to_workbook
      subject.save_workbook
      workbook = RubyXL::Parser.parse("#{ROOT}/exports/test.xlsx")
      worksheet = workbook['Sheet1']
      expect(worksheet).to be_nil
    end

    it 'can\'t write if there is no data present' do
      begin
        subject.excel_file = "#{ROOT}/exports/test.xlsx"
        subject.create_workbook
        expect(subject.write_to_workbook).to raise_error(SystemExit)
      rescue SystemExit => exit_status
        expect(exit_status.status).to eq 1
      end
    end 

     it 'writes to the workbook' do
      subject.excel_file = "#{ROOT}/exports/test.xlsx"
      subject.create_workbook
      subject.sql_data = ['test_header': "test"]
      subject.write_to_workbook
      subject.save_workbook

      workbook = RubyXL::Parser.parse("#{ROOT}/exports/test.xlsx")
      worksheet = workbook['accessions']
      data = worksheet.sheet_data[0][0].value
      expect(data.to_s).to eq("test") 
    end
  end 

  describe '.write_headers' do
    it 'writes sql keys to headers' do
      subject.excel_file = "#{ROOT}/exports/test.xlsx"
      subject.create_workbook
      subject.sql_data = ['test_header': "test"]
      subject.write_to_workbook
      subject.write_headers
      subject.save_workbook

      workbook = RubyXL::Parser.parse("#{ROOT}/exports/test.xlsx")
      worksheet = workbook['accessions']
      data = worksheet.sheet_data[0][0].value
      expect(data.to_s).to eq("test_header") 
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