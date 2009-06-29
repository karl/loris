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
    
    @action = mock('action')
    @action.should_receive(:action).ordered {
      continue = false
    }
  end

  it "should wait and call action while contunuer returns true" do
    p = Poller.new(@waiter, @continuer, @action)
    p.start()
  end

  it "should notify observers at the end of each action" do
    obs = mock('observer')
    obs.should_receive(:update)

    p = Poller.new(@waiter, @continuer, @action)
    
    p.add_observer(obs)
    
    p.start()
  end

end


