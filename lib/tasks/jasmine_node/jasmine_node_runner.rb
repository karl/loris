class JasmineNodeRunner
  
  def initialize(node, spec_dir, dir, filter)
    @node = node
    @spec_dir = spec_dir
    @dir = dir
    @filter = filter
  end
  
  def name
    return 'Jasmine'
  end
  
  def execute
    return `#{@node} #{@spec_dir}/specs.js --noColor #{@dir}  2>&1`
  end
  
  def is_configured?(all_files)
    return true
  end
  
  def should_run?(modified_files)
    return !(modified_files.detect { |file| @filter.filter(file) }).nil?
  end
  
end