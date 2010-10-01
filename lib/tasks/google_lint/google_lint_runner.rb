class GoogleLintRunner
  
  def initialize(binary, fix_style_binary, dir, filter, config)
    @binary = binary
    @fix_style_binary = fix_style_binary
    @config_file = dir + '/gjslint.yml'
    @dir = dir
    @filter = filter
    @config = config
  end
  
  def name
    return 'Google Lint'
  end
  
  def execute
    @config.reload
    conf = @config.conf

    input_params = ''
    run_fix_style = false

    conf.each do |param, value|

      if param == 'strict'
        input_params += " --#{param}"
        next
      end
      
      if param == 'run-fix-style'
        run_fix_style = true
        next
      end

      if value.kind_of? Array
        
        value.each do |inner_value|
          input_params += " --#{param} \"#{inner_value}\""
        end
        
      elsif value.kind_of? Integer
        input_params += " --#{param} #{value}"
      else
        input_params += " --#{param} \"#{value}\""
      end
    end

    result = ''
    result += `#{@fix_style_binary} #{input_params} . 2>&1` if run_fix_style

    return result + `#{@binary} #{input_params} . 2>&1`
  end
  
  def is_configured?(all_files)
    return all_files.include?(@config_file)
  end
  
  def should_run?(modified_files)
    return !(modified_files.detect { |file| @filter.filter(file) }).nil? || modified_files.include?(@config_file)
  end
  
end