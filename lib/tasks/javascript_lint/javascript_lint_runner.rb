class JavascriptLintRunner
  
  def initialize(binary, dir, filter)
    @binary = binary
    @config = dir + '/jsl.conf'
    @dir = dir
    @filter = filter
  end
  
  def name
    return 'Javascript Lint'
  end
  
  def execute
    return `#{@binary} -conf "#{@config}" -nologo -nofilelisting 2>&1`
  end
  
  def is_configured?(all_files)
    return all_files.include?(@config)
  end
  
  def should_run?(modified_files)
    return !(modified_files.detect { |file| @filter.filter(file) }).nil? || modified_files.include?(@config)
  end
  
end