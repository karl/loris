require 'lib/modified_filter'
require 'time'

describe ModifiedFilter do
  
  before do
    @path = '/path/to.file'  
    @file = mock('File class')
    @file.should_receive(:mtime).any_number_of_times.with(@path).and_return(Time.parse('2000/01/01'))
  end
  
  it 'should return true if no last modified date set' do
    filter = ModifiedFilter.new(@file)
    
    filter.filter(@path).should be_true
  end
  
  it 'should return false if file modified before given last modified date' do
    last_modified = Time.parse('2000/01/02')
    filter = ModifiedFilter.new(@file, last_modified)
    
    filter.filter(@path).should be_false 
  end
  
  it 'should remember the last modified date on complete method' do
    filter = ModifiedFilter.new(@file)
    filter.filter(@path)
    
    filter.complete
    
    filter.filter(@path).should be_false
  end
  
  it 'should remember the last modified date and recognise changed date on file' do
    @file = mock('File class')
    @file.should_receive(:mtime).with(@path).and_return(Time.parse('2000/01/01'))
    @file.should_receive(:mtime).with(@path).and_return(Time.parse('2000/01/03'))

    filter = ModifiedFilter.new(@file)
    filter.filter(@path)
    
    filter.complete
    
    filter.filter(@path).should be_true
  end
  
end
