require 'lib/poller.rb'

describe Poller do

  it "should wait and call action while contunuer returns true" do

    # continue = true
    # continuer = mock('continuer')
    # continuer.should_receive(:continue?).any_number_of_times {
    #   continue
    # }
    # 
    # waiter = mock('waiter')
    # waiter.should_receive(:wait).ordered
    # 
    # action = mock('action')
    # action.should_receive(:action).ordered {
    #   continue = false
    # }
    # 
    # p = Poller.new(waiter, continuer, action)
    # p.start()

  end

end


