require 'lib/file_finder'

describe FileFinder do
  
  before do
    finder = mock('finder')
    finder.should_receive(:find).with('/monkey').and_yield('/monkey/modified.txt').and_yield('/monkey/modified-2.txt').and_yield('/monkey/not-modified.txt')

    @filter = mock('filter')
    @filter.should_receive(:filter).at_most(1).with('/monkey/modified.txt').and_return(true)
    @filter.should_receive(:filter).at_most(1).with('/monkey/modified-2.txt').and_return(true)
    @filter.should_receive(:filter).at_most(1).with('/monkey/not-modified.txt').and_return(false)
    
    @filter2 = mock('filter')
    @filter2.should_receive(:filter).at_most(1).with('/monkey/modified.txt').and_return(true)
    @filter2.should_receive(:filter).at_most(1).with('/monkey/modified-2.txt').and_return(false)
    @filter2.should_receive(:filter).at_most(1).with('/monkey/not-modified.txt').and_return(true)
    
    dir = '/monkey'
    @ff = FileFinder.new(finder, dir)
  end
  
  it 'with no filters, should return all files' do
    result = { 
      :all => ['/monkey/modified.txt', '/monkey/modified-2.txt', '/monkey/not-modified.txt'],
      :filtered => ['/monkey/modified.txt', '/monkey/modified-2.txt', '/monkey/not-modified.txt'] 
    }

    files = @ff.find
    files.should eql result
  end
  
  it 'with filter, should return only filtered' do
    result = { 
      :all => ['/monkey/modified.txt', '/monkey/modified-2.txt', '/monkey/not-modified.txt'],
      :filtered => ['/monkey/modified.txt', '/monkey/modified-2.txt'] 
    }

    @filter.should_receive(:complete)

    @ff.add_filter(@filter)
    files = @ff.find
    
    files.should eql result
  end
  
  it 'should be able to accept multiple filters' do
    result = { 
      :all => ['/monkey/modified.txt', '/monkey/modified-2.txt', '/monkey/not-modified.txt'],
      :filtered => ['/monkey/modified.txt'] 
    }

    @filter.should_receive(:complete)
    @filter2.should_receive(:complete)
 
    @ff.add_filter(@filter)
    @ff.add_filter(@filter2)
    files = @ff.find
    
    files.should eql result
  end
  
  it 'should call filter.complete methods at the end of find' do
    @filter.should_receive(:complete)
    @filter2.should_receive(:complete)

    @ff.add_filter(@filter)
    @ff.add_filter(@filter2)
    files = @ff.find
    
  end
  
end
