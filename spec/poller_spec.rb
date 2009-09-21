require 'lib/poller.rb'

describe Poller do

  before do
    continue = true
    @continuer = mock('continuer')
    @continuer.should_receive(:continue?).any_number_of_times {
      continue
    }
    
    @waiter = mock('waiter')
    @waiter.should_receive(:wait).ordered
    
    @action = mock('actioner')
    @action.should_receive(:run).ordered {
      continue = false
    }
  end

  it "should wait and call action while contunuer returns true" do
    p = Poller.new(@waiter, @continuer, @action)
    p.start
  end

end


