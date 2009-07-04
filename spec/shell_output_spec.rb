require 'lib/shell_output.rb'

describe ShellOutput do

  it "should output title, state, summary, and detail" do
    result = {
      :state => :success,
      :title => 'Example Title',
      :summary => 'Example Summary',
      :detail => 'Detail goes here...'
    }
    
    output = mock('Output')
    output.should_receive(:puts).with(:success)
    output.should_receive(:puts).with('Example Title')
    output.should_receive(:puts).with('Example Summary')
    output.should_receive(:puts).with('Detail goes here...')
    
    shell_output = ShellOutput.new(output)
    shell_output.add_result(result)
  end

end


