class OutputAction
 
  def initialize(output, format_string = "%s")
    @output = output
    @format_string = format_string
  end
  
  def action(paths)
    paths.each do |path|
      @output.puts(@format_string % path)
    end
    @output.flush()
  end
  
end