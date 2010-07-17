class JasmineNodeConfig
  
  def initialize(dir, json, file)
    @config_path = dir + '/jasmine.conf'
    @json = json
    @file = file
  end
  
  def config_path
    return @config_path
  end
  
  def reload
    contents = File.open(@config_path, 'r') { |f| f.read }
    @config = @json.parse contents
  end
  
  def source_dir
    return @config["sourceDirectory"]
  end
  
  def spec_dir
    return @config["specDirectory"]
  end
  
  def requires
    return @config["requires"]
  end
  
end