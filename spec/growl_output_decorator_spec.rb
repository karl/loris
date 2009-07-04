require 'lib/growl_output_decorator.rb'

describe GrowlOutputDecorator do

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
    growl.should_receive(:notify)
    
    growl_output = GrowlOutputDecorator.new(output, growl)
    growl_output.add_result(result)
  end

  it "should notify title and summary to growl" do
    result = {
      :state => :success,
      :title => 'Example Title',
      :summary => 'Example Summary',
      :detail => 'Detail goes here...'
    }
    
    output = mock('Output')
    output.should_receive(:add_result)
    
    growl = mock('Growl')
    growl.should_receive(:notify)

    # Don't know how to specify this interaction with growl!
    
    growl_output = GrowlOutputDecorator.new(output, growl)
    growl_output.add_result(result)
  end

end


