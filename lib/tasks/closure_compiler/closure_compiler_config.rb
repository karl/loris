class ClosureCompilerConfig
  
  def initialize(dir, yaml, uri)
    @config_file = dir + '/closure-compiler.yml'
    @yaml = yaml
    @uri = uri
  end
  
  def reload
    @conf = @yaml.load_file(@config_file)
  end
  
  def conf
    return @conf
  end
  
end