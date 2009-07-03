require 'lib/file_actioner.rb'

describe FileActioner do

  it "Should get filtered files and send them to action" do
    
    ff = mock('file finder')
    ff.should_receive(:get_filtered_files).and_return(['/path/to.file'])

    tm = mock('TaskManager')
    tm.should_receive(:run).with(['/path/to.file'])

    fa = FileActioner.new(ff, tm)
    fa.run()

  end
  
  it "should not run the actions if no filtered files" do
    ff = mock('file finder')
    ff.should_receive(:get_filtered_files).and_return([])

    tm = mock('TaskManager')
    tm.should_not_receive(:run)

    fa = FileActioner.new(ff, tm)
    fa.run()
    
  end

end


