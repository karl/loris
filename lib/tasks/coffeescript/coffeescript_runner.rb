class CoffeeScriptRunner
  
  def initialize(binary, dir, filter)
    @binary = binary
    @dir = dir
    @filter = filter

    @coffee_dir = dir + '/coffee'
    @js_dir = dir + '/src'
  end
  
  def name
    return 'CoffeeScript'
  end
  
  def execute
    return `#{@binary} --compile #{@coffee_dir} --output #{@js_dir}  2>&1`
  end
  
  def is_configured?(all_files)
    return true
  end
  
  def should_run?(modified_files)
    return !(modified_files.detect { |file| @filter.filter(file) }).nil? || modified_files.include?(@config)
  end
  
end