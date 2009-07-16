require 'lib/growl_output_decorator.rb'

describe GrowlOutputDecorator do

  it "should not notify if growl is not installed" do
    result = {}
    
    output = mock('Output')
    output.should_receive(:add_result).with(result)
    
    growl = mock('Growl')
    growl.should_receive(:installed?).and_return(false)
        
    growl_output = GrowlOutputDecorator.new(output, growl)
    growl_output.add_result(result)
  end

  it "should call original add_result method" do
    result = {
      :state => :success,
      :title => 'Example Title',
      :summary => 'Example Summary',
      :detail => 'Detail goes here...'
    }
    
    output = mock('Output')
    output.should_receive(:add_result).with(result)
    
    growl = mock('Growl')
    growl.should_receive(:installed?).and_return(true)
    growl.should_receive(:notify)
    
    growl_output = GrowlOutputDecorator.new(output, growl)
    growl_output.add_result(result)
  end

end


