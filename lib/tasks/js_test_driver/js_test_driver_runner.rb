class JsTestDriverRunner
    
  def initialize(dir, jar, filter)
    @config = dir + '/jsTestDriver.conf'
    @dir = dir
    @jar = jar
    @filter = filter
  end
  
  def execute()
    return `java -jar "#{@jar}" --config "#{@config}" --tests all --verbose 2>&1`
  end
  
  def is_configured?(all_files)
    return all_files.include?(@dir + '/jsTestDriver.conf')
  end
  
  def should_run?(modified_files)
    return !(modified_files.detect { |file| @filter.filter(file)  }).nil? || modified_files.include?(@config)
  end
  
end