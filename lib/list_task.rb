class ListTask
 
  def initialize(format_string = "%s")
    @format_string = format_string
  end
  
  def run(paths)
    detail = ""
    paths.each do |path|
      detail += (@format_string % path)
      detail += "\n"
    end
    
    return {
        :success => true,
        :title => 'List',
        :summary => '%s file%s.' % [paths.length, paths.length == 1 ? '' : 's'],
        :detail => detail
      }
  end
  
end