class JSpecRunner

  def initialize(dir, filter)
    @config = dir + '/spec/spec.rhino.js'
    @dir = dir
    @filter = filter
  end
  
  def execute
    return `jspec run --rhino --trace 2>&1`
  end
  
  def is_configured?(all_files)
    return all_files.include?(@config)
  end
  
  def should_run?(modified_files)
    return !(modified_files.detect { |file| @filter.filter(file) }).nil?
  end
  
end