require 'lib/filters/ends_with_filter'

describe EndsWithFilter do
  
  before do
  end
  
  it 'should return true if ends with text' do
    @path = '/path/to/file_spec.rb'
    filter = EndsWithFilter.new('_spec.rb')
    filter.filter(@path).should be_true
  end
  
  it 'should return true if ends with text in a different case' do
    @path = '/path/to/file_Spec.RB'
    filter = EndsWithFilter.new('_spec.rb')
    filter.filter(@path).should be_true
  end
  
  it 'should return false if does not end with text' do
    @path = '/path/to/file_spec.rbx'
    filter = EndsWithFilter.new('_spec.rb')
    filter.filter(@path).should be_false
  end
  
end
