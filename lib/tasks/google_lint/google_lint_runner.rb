class GoogleLintRunner
  
  def initialize(binary, dir, filter)
    @binary = binary
    @config = dir + '/gjslint.conf'
    @dir = dir
    @filter = filter
  end
  
  def name
    return 'Google Lint'
  end
  
  def execute
    return `#{@binary} --strict --recurse . 2>&1`
  end
  
  def is_configured?(all_files)
    return all_files.include?(@config)
  end
  
  def should_run?(modified_files)
    return !(modified_files.detect { |file| @filter.filter(file) }).nil? || modified_files.include?(@config)
  end
  
end