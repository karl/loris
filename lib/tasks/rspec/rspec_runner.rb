class RSpecRunner
    
  def initialize(dir)
    @dir = dir
  end
  
  def execute()
    return `spec . 2>&1`
  end
  
  def is_configured?(all_files)
    return all_files.detect { |file| /_spec\.rb$/ =~ file }
  end
  
end