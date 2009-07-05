class JavascriptLintRunner
  
  def initialize(dir)
    @dir = dir
  end
  
  def execute()
    return `jsl -conf "jsl.conf" -nologo -nofilelisting -process "#{@dir}" 2>&1`
  end
  
end