require 'lib/output_action.rb'

describe OutputAction do

  before do
    @text = ""

    @output = mock('output')
    @output.should_receive(:puts) { |txt|
      @text += txt + "\n"
    }
    @output.should_receive(:flush).at_least(1)
    
    @files = ['/path/to.file']    
  end

  it "should output the given paths" do
  
    oa = OutputAction.new(@output)
    oa.action(@files)

    @text.should eql "/path/to.file\n"
  end

  it "should output the given paths using the given format string" do
    format_string = "the file '%s' has been modified!"

    oa = OutputAction.new(@output, format_string)
    oa.action(@files)

    @text.should eql "the file '/path/to.file' has been modified!\n"
  end

end


