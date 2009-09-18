class JSpecRunner

  def initialize(dir)
    @dir = dir
  end
  
  def execute
    return `jspec run --rhino --trace 2>&1`
  end
  
  def is_configured?(all_files)
    return all_files.include?(@dir + '/spec/spec.rhino.js')
  end
  
end