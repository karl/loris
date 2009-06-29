class Poller
 
  def initialize(waiter, continuer, action)
    @waiter = waiter
    @continuer = continuer
    @action = action
  end
  
  def start
    while @continuer.continue?
      @waiter.wait
      @action.action
    end
  end
    
end