require 'lib/list_task.rb'

describe ListTask do

  before do
    @files = ['/path/to.file']    
  end

  it "should output the given paths" do
    oa = ListTask.new()
    result = oa.run(@files)

    result[:detail].should eql "/path/to.file\n"
  end

  it "should output the given paths using the given format string" do
    format_string = "the file '%s' has been modified!"

    oa = ListTask.new(format_string)
    result = oa.run(@files)

    result[:detail].should eql "the file '/path/to.file' has been modified!\n"
  end

  it "should return a title" do
    oa = ListTask.new()
    result = oa.run(@files)

    result[:title].should eql "List"
  end

  it "should return success always" do
    oa = ListTask.new()
    result = oa.run(@files)

    result[:success].should be_true
  end

  it "should return summary for 1 file" do
    oa = ListTask.new()
    result = oa.run(@files)

    result[:summary].should eql "1 file."
  end

  it "should return summary for 3 files" do
    oa = ListTask.new()
    result = oa.run(['first.file','second.file','third.file'])

    result[:summary].should eql "3 files."
  end

end


