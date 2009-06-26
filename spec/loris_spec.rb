require 'lib/loris.rb'

describe Loris do

  it "should say hello" do

    loris = Loris::Test.new

    loris.hello().should == 'Hello'

  end

end