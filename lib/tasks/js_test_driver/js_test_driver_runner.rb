class JsTestDriverRunner
    
  def initialize(dir, jar, filter, server)
    @config = dir + '/jsTestDriver.conf'
    @dir = dir
    @jar = jar
    @filter = filter
    @server = server
  end
  
  def name
    return 'JS Test Driver'
  end
  
  def execute
    @server.start_if_required
    return `java -jar "#{@jar}" --config "#{@config}" --reset --tests all 2>&1`
  end
  
  def is_configured?(all_files)
    return all_files.include?(@dir + '/jsTestDriver.conf')
  end
  
  def should_run?(modified_files)
    return !(modified_files.detect { |file| @filter.filter(file)  }).nil? || modified_files.include?(@config)
  end
  
end