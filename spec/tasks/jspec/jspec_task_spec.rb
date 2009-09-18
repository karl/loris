require 'lib/tasks/jspec/jspec_task.rb'

describe JSpecTask do

  before do
    @files = {
      :all => [], 
      :filtered => [] 
    }
  end

  it "should return error if unable to parse jspec output" do
    jspec = mock('JSpec Runner')
    jspec.should_receive(:is_configured?).and_return(true)
    jspec.should_receive(:execute).and_return('A JSpec error message here...')
    
    jspec_task = JSpecTask.new(jspec)
    result = jspec_task.run(@files)
    
    result[:state].should eql :error
  end

  it "should return success if all tests pass" do
    jspec = mock('JSpec Runner')
    jspec.should_receive(:is_configured?).and_return(true)
    jspec.should_receive(:execute).and_return('Passes: 3 Failures: 0')
    
    jspec_task = JSpecTask.new(jspec)
    result = jspec_task.run(@files)
    
    result[:state].should eql :success
  end

  it "should return failure if any test fails" do
    jspec = mock('JSpec Runner')
    jspec.should_receive(:is_configured?).and_return(true)
    jspec.should_receive(:execute).and_return('Passes: 2 Failures: 1')
    
    jspec_task = JSpecTask.new(jspec)
    result = jspec_task.run(@files)
    
    result[:state].should eql :failure
  end

end


