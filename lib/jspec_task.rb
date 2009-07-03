class JSpecTask
 
  def initialize()
  end
  
  def run(modified_files)
    results = "JSpec:\n"
    results += `jspec run --rhino`

    return results
  end
  
end