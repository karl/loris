class ClearingOutputDecorator
  
  def initialize(output)
    @output = output
  end
  
  def start_run()
    clear = RUBY_PLATFORM =~ /mswin32/ ? 'cls' : 'clear'
    system clear
    
    @output.start_run()
  end
  
  def add_result(result)    
      @output.add_result(result)
  end
  
end