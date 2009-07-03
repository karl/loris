class JSpecTask
 
  def initialize()
  end
  
  def run(modified_files)
    detail = `jspec run --rhino`

    return {
        :success => true,
        :title => 'JSpec',
        :summary => 'jspec summary',
        :detail => detail
      }
  end
  
end