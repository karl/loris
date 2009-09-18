require 'lib/tasks/jspec/jspec_runner.rb'

describe JSpecRunner do

  before do
    @filter = mock('JS Extension Filter')
  end

  describe "is_configured?" do

    it "should return true if spec/spec.rhino.js exists" do

      dir = '/a/dir/structure'
      all_files = ['/a/dir/structure/spec/spec.rhino.js']
      
      runner = JSpecRunner.new(dir, @filter)
      
      runner.is_configured?(all_files).should be_true
      
    end

    it "should return false if spec/spec.rhino.js does not exists" do

      dir = '/a/dir/structure'
      all_files = ['/a/dir/structure/spec/other_js_spec_file.js']
      
      runner = JSpecRunner.new(dir, @filter)
      
      runner.is_configured?(all_files).should be_false
      
    end

  end
  
  describe "should_run?" do

    it "should return true if a file ends with a js extension" do

      dir = '/a/dir/structure'
      modified_files = ['/a/dir/structure/another_dir/example.js']
      @filter.should_receive(:filter).and_return(true)
      
      runner = JSpecRunner.new(dir, @filter)
      
      runner.should_run?(modified_files).should be_true
      
    end

    it "should return true if any file ends with a js extension" do

      dir = '/a/dir/structure'
      modified_files = ['/a/dir/structure/nonjs.file', '/a/dir/structure/another_dir/example.js']
      @filter.should_receive(:filter).ordered.and_return(false)
      @filter.should_receive(:filter).ordered.and_return(true)
      
      runner = JSpecRunner.new(dir, @filter)
      
      runner.should_run?(modified_files).should be_true
      
    end

    it "should return false if no file ends with a js extension" do

      dir = '/a/dir/structure'
      modified_files = ['/a/dir/structure/nonjs.file']
      @filter.should_receive(:filter).ordered.and_return(false)
      
      runner = JSpecRunner.new(dir, @filter)
      
      runner.should_run?(modified_files).should be_false
      
    end

  end

end


