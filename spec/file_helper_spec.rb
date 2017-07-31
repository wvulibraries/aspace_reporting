require 'file_helper'
describe FileHelper do
  describe 'initialize' do 
    it 'file_path should be the custom value given' do 
      fh = FileHelper.new('somepath/somefile.txt')
      expect(fh.file_path).to eq('somepath/somefile.txt')
    end
  end

  describe 'attributes' do
    it 'allows reading and writing of the file_path' do
      fh = FileHelper.new('somepath/somefile.txt')
      fh.file_path = 'test/test.txt'
      expect(fh.file_path).to eq('test/test.txt')
    end
  end 

  describe '.get_file_contents' do
    it 'returns the contents of a file when given a proper path' do
      fh = FileHelper.new('somepath/somefile.txt')
      fh.file_path = "#{ROOT}/spec/files/test.txt"
      expect(fh.get_file_contents).to eq("test")
    end
  end 
end