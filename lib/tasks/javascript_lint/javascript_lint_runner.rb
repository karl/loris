class JavascriptLintRunner
  
  def initialize(dir)
    @dir = dir
  end
  
  def execute()
    return `jsl -conf "jsl.conf" -nologo -nofilelisting 2>&1`
  end
  
  def is_configured?(all_files)
    return all_files.include?(@dir + '/jsl.conf')
  end
  
end