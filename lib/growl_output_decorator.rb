class GrowlOutputDecorator
  
  def initialize(output, growler)
    @output = output
    @growler = growler
  end
  
  def add_result(result)    
      @growler.notify {
        self.title = result[:title]
        self.message = result[:summary]
        self.icon = :ruby
      }
    
      @output.add_result result
  end
  
end