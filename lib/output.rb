class Output
  
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
    
      @output.puts result[:title]
      @output.puts result[:success]
      @output.puts result[:summary]
      @output.puts result[:detail]
  end
  
end