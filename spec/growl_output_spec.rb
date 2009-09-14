require 'lib/outputs/growl_output.rb'

describe GrowlOutput do

  it "should not notify if growl is not installed" do
    result = {}
    
    growl = mock('Growl')
    growl.should_receive(:installed?).and_return(false)
        
    growl_output = GrowlOutput.new(growl)
    growl_output.add_result(result)
  end

  it "should call original add_result method" do
    result = {
      :state => :success,
      :title => 'Example Title',
      :summary => 'Example Summary',
      :detail => 'Detail goes here...'
    }
    
    growl = mock('Growl')
    growl.should_receive(:installed?).and_return(true)
    growl.should_receive(:notify)
    
    growl_output = GrowlOutput.new(growl)
    growl_output.add_result(result)
  end

end


