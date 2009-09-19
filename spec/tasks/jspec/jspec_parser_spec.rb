require 'lib/tasks/jspec/jspec_parser.rb'

describe JSpecParser do

  it "should return error if unable to parse jspec output" do
    jspec_parser = JSpecParser.new()
    state, summary, first = jspec_parser.parse_result('A JSpec error message here...')
    
    state.should eql :error
  end

  it "should return success if all tests pass" do
    jspec_parser = JSpecParser.new()
    state, summary, first = jspec_parser.parse_result('Passes: 3 Failures: 0')
    
    state.should eql :success
  end

  it "should return failure if any test fails" do
    jspec_parser = JSpecParser.new()
    state, summary, first = jspec_parser.parse_result('Passes: 2 Failures: 1')
    
    state.should eql :failure
  end

end


