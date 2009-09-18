class RSpecRunner
    
  def initialize(dir, ruby_filter, spec_filter)
    @dir = dir
    @ruby_filter = ruby_filter
    @spec_filter = spec_filter
  end
  
  def execute()
    return `spec . 2>&1`
  end
  
  def is_configured?(all_files)
    return !(all_files.detect { |file| @spec_filter.filter(file) }).nil?
  end
  
  def should_run?(modified_files)
    return !(modified_files.detect { |file| @ruby_filter.filter(file) }).nil?
  end
  
end