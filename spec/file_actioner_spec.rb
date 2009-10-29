require 'lib/file_actioner.rb'

describe FileActioner do

  # it "Should get filtered files and send them to action" do
  #   files = {
  #     :all => ['/path/to.file'], 
  #     :filtered => ['/path/to.file'] 
  #   }
  #   
  #   ff = mock('file finder')
  #   ff.should_receive(:find).and_return(files)
  # 
  #   tm = mock('TaskManager')
  #   tm.should_receive(:run).with(files)
  # 
  #   fa = FileActioner.new(ff, tm)
  #   fa.run
  # 
  # end
  # 
  # it "should not run the actions if no filtered files" do
  #   files = {
  #     :all => ['/path/to.file'], 
  #     :filtered => [] 
  #   }
  # 
  #   ff = mock('file finder')
  #   ff.should_receive(:find).and_return(files)
  # 
  #   tm = mock('TaskManager')
  #   tm.should_not_receive(:run)
  # 
  #   fa = FileActioner.new(ff, tm)
  #   fa.run
  #   
  # end

end


