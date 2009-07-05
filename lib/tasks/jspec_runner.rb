class JSpecRunner
  
  def execute
    return `jspec run --rhino --trace 2>&1`
  end
  
end