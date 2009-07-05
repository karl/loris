class ListTask
 
  def initialize(format_string = "%s")
    @format_string = format_string
  end
  
  def run(paths)
    return {
        :state => :success,
        :title => 'List',
        :first => paths.length == 1 ? paths[0] : '%s files.' % paths.length,
        :detail => get_detail(paths)
      }
  end
  
  def get_detail(paths)
    detail = ""
    limit = [paths.length, 15].min
    (0..limit).each do |i|
      path = paths[i]
      detail += (@format_string % path)
      detail += "\n"
    end
    if limit < paths.length
      detail += " - Plus #{paths.length - limit} more files."
    end

    return detail
  end
  
end