class OutputCollection
 
  def initialize
    @outputs = []
  end

  def start_run
    @outputs.each do |output|
      output.start_run
    end
  end
  
  def add(output)
    @outputs << output
  end
  
  def add_result(result)
    @outputs.each do |output|
      output.add_result(result)
    end
  end
  
end