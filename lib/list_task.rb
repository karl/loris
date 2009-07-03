class ListTask
 
  def initialize(format_string = "%s")
    @format_string = format_string
  end
  
  def run(paths)
    result = "List:\n"
    paths.each do |path|
      result += (@format_string % path)
      result += "\n"
    end
    return result
  end
  
end