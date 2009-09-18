require 'lib/tasks/javascript_lint/javascript_lint_runner.rb'

describe JavascriptLintRunner do

  before do
    @filter = mock('JS Extension Filter')
  end

  describe "is_configured?" do

    it "should return true if jsl.conf exists" do

      dir = '/a/dir/structure'
      all_files = ['/a/dir/structure/jsl.conf']
      
      runner = JavascriptLintRunner.new(dir, @filter)
      
      runner.is_configured?(all_files).should be_true
      
    end

    it "should return false if jsl.conf does not exists" do

      dir = '/a/dir/structure'
      all_files = ['/a/dir/structure/other.conf']
      
      runner = JavascriptLintRunner.new(dir, @filter)
      
      runner.is_configured?(all_files).should be_false
      
    end

  end
  
  describe "should_run?" do

    it "should return true if a file ends with a js extension" do

      dir = '/a/dir/structure'
      modified_files = ['/a/dir/structure/another_dir/example.js']
      @filter.should_receive(:filter).and_return(true)
      
      runner = JavascriptLintRunner.new(dir, @filter)
      
      runner.should_run?(modified_files).should be_true
      
    end

    it "should return true if any file ends with a js extension" do

      dir = '/a/dir/structure'
      modified_files = ['/a/dir/structure/nonjs.file', '/a/dir/structure/another_dir/example.js']
      @filter.should_receive(:filter).ordered.and_return(false)
      @filter.should_receive(:filter).ordered.and_return(true)
      
      runner = JavascriptLintRunner.new(dir, @filter)
      
      runner.should_run?(modified_files).should be_true
      
    end

    it "should return false if no file ends with a js extension" do

      dir = '/a/dir/structure'
      modified_files = ['/a/dir/structure/nonjs.file']
      @filter.should_receive(:filter).ordered.and_return(false)
      
      runner = JavascriptLintRunner.new(dir, @filter)
      
      runner.should_run?(modified_files).should be_false
      
    end

    it "should return true if the jsl.conf file was modified" do

      dir = '/a/dir/structure'
      modified_files = ['/a/dir/structure/jsl.conf']
      @filter.should_receive(:filter).ordered.and_return(false)
      
      runner = JavascriptLintRunner.new(dir, @filter)
      
      runner.should_run?(modified_files).should be_true
      
    end

  end

end


