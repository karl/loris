class JsTestDriverConfig
  
  def initialize(dir, yaml, uri)
    @config_file = dir + '/jsTestDriver.conf'
    @yaml = yaml
    @uri = uri
  end
  
  def reload
    @conf = @yaml.load_file(@config_file)
    @server = @uri.parse(@conf['server'])
  end
  
  def host
    return @server.host
  end
  
  def port
    return @server.port
  end
  
end