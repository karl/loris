class Poller

  def initialize(waiter, continuer, action)
    @waiter = waiter
    @continuer = continuer
    @action = action
  end
  
  def start
    ran = false
    while @continuer.continue?
      @waiter.wait unless ran
      ran = @action.run
    end
  end
    
end