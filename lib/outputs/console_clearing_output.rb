class ConsoleClearingOutput
  
  def initialize()
  end
  
  def start_run()
    clear = RUBY_PLATFORM =~ /mswin32/ ? 'cls' : 'clear'
    system clear
  end
  
  def add_result(result)    
  end
  
end