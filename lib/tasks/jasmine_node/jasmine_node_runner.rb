class JasmineNodeRunner
  
  def initialize(node, spec_dir, dir, filter, config)
    @node = node
    @spec_dir = spec_dir
    @dir = dir
    @filter = filter
    @config = config
    @source_args = "";
  end
  
  def name
    return 'Jasmine'
  end
  
  def execute
    return `"#{@node}" "#{@spec_dir}/specs.js" --noColor #{@source_args} "#{@config.config_path}"  2>&1`
  end
  
  def is_configured?(all_files)
    return all_files.include?(@config.config_path)
  end
  
  def should_run?(modified_files)
    return !(modified_files.detect { |file| @filter.filter(file) }).nil? || modified_files.include?(@config.config_path)
  end
  
  def source_dir(source_dir)
    @source_args = source_dir.nil? ? "" : "--source-directory \"#{source_dir}\""
  end
  
end