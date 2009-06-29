class SleepWaiter
 
  def initialize(sleep_time = 1)
    @sleep_time = sleep_time
  end
 
  def wait
    sleep @sleep_time
  end
    
end