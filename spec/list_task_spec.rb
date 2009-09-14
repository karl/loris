require 'lib/tasks/list_task.rb'

describe ListTask do

  before do
    @files = {
      :all => ['/path/to.file', '/not/in.filtered'],
      :filtered => ['/path/to.file']    
    }
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

    result[:state].should eql :success
  end

  it "should return summary for 1 file" do
    oa = ListTask.new()
    result = oa.run(@files)

    result[:first].should eql @files[:filtered][0]
  end

  it "should return summary for 3 files" do
    oa = ListTask.new()
    result = oa.run({ :filtered => ['first.file','second.file','third.file'] })

    result[:first].should eql "3 files."
  end

end


