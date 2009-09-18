class JsTestDriverRunner
    
  def initialize(dir, jar)
    @dir = dir
    @jar = jar
  end
  
  def execute()
    return `java -jar "#{@jar}" --config "jsTestDriver.conf" --tests all --verbose 2>&1`
  end
  
  def is_configured?(all_files)
    return all_files.include?(@dir + '/jsTestDriver.conf')
  end
  
end