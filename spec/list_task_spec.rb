require 'lib/list_task.rb'

describe ListTask do

  before do
    @files = ['/path/to.file']    
  end

  it "should output the given paths" do
    oa = ListTask.new()
    result = oa.run(@files)

    result.should eql "List:\n/path/to.file\n"
  end

  it "should output the given paths using the given format string" do
    format_string = "the file '%s' has been modified!"

    oa = ListTask.new(format_string)
    result = oa.run(@files)

    result.should eql "List:\nthe file '/path/to.file' has been modified!\n"
  end

end


