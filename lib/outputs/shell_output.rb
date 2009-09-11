class ShellOutput
  
  def initialize(output)
    @output = output
  end
  
  def start_run()
  end
  
  def add_result(result)    
      @output.puts result[:title]
      @output.puts result[:state]
      @output.puts result[:summary]
      @output.puts result[:detail]
  end
  
end