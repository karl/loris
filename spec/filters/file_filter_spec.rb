require 'lib/filters/file_filter'

describe FileFilter do
  
  before do
  end
  
  it 'should return true if a file' do
    @path = '/path/to.file'
    @file = mock('File class')
    @file.should_receive(:file?).with(@path).and_return(true)

    filter = FileFilter.new(@file)
    
    filter.filter(@path).should be_true
  end
  
  it 'should return false if a directory' do
    @path = '/path/to/dir'
    @file = mock('File class')
    @file.should_receive(:file?).with(@path).and_return(false)

    filter = FileFilter.new(@file)
    
    filter.filter(@path).should be_false
  end
  
end
