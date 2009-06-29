require 'lib/modified_filter'
require 'time'

describe ModifiedFilter do
  
  it 'should return true if no last modified date set' do
    path = '/path/to.file'  
    file = mock('File class')
    file.should_receive(:mtime).any_number_of_times.with(path).and_return(Time.parse('2000/01/01'))

    filter = ModifiedFilter.new(file)
    
    filter.filter(path).should be_true
  end
  
  it 'should return false if file modified before given last modified date' do
    path = '/path/to.file'  
    last_modified = Time.parse('2000/01/02')
    file = mock('File class')
    file.should_receive(:mtime).any_number_of_times.with(path).and_return(Time.parse('2000/01/01'))
    
    filter = ModifiedFilter.new(file)
    filter.set_last_modified(last_modified)
    
    filter.filter(path).should be_false 
  end
  
end
