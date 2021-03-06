class ClosureCompilerRunner
  
  def initialize(jar, dir, filter, config)
    @jar = jar
    @config_file = dir + '/closure-compiler.yml'
    @dir = dir
    @filter = filter
    @config = config
    @output_file = ''
  end
  
  def name
    return 'Closure Compiler'
  end
  
  def execute
    @config.reload
    conf = @config.conf
    
    @output_file = conf['js_output_file']
    
    input_params = ''

    conf.each do |param, value|
        
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
    
    return `java -Xmx1024m -jar "#{@jar}" #{input_params} 2>&1`
  end
  
  def is_configured?(all_files)
    return all_files.include?(@config_file)
  end
  
  def should_run?(modified_files)
    return !(modified_files.detect { |file| @filter.filter(file) && file != @dir + '/' + @output_file }).nil? || modified_files.include?(@config_file)
  end
  
end