require 'observer'

class Poller
  include Observable
 
  def initialize(waiter, continuer, action)
    @waiter = waiter
    @continuer = continuer
    @action = action
  end
  
  def start
    while @continuer.continue?
      @waiter.wait
      @action.action
      changed
      notify_observers
    end
  end
    
end