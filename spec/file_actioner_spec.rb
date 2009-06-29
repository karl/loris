require 'lib/file_actioner.rb'

describe FileActioner do

  it "Should get filtered files and send them to action" do
    
    ff = mock('file finder')
    ff.should_receive(:get_filtered_files).and_return(['/path/to.file'])

    a = mock('action')
    a.should_receive(:action).with(['/path/to.file'])

    a = FileActioner.new(ff, a)
    a.action()

  end

end


