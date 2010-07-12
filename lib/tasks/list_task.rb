class ListTask
 
  def initialize(format_string = "%s")
    @format_string = format_string
  end
  
  def run(files)
    all_files = files[:all]
    mofified_files = files[:filtered]

    return {
        :state => :success,
        :title => 'List',
        :first => mofified_files.length == 1 ? mofified_files[0] : '%s files.' % mofified_files.length,
        :detail => get_detail(mofified_files)
      }
  end
  
  def get_detail(paths)
    detail = ""
    limit = [paths.length - 1, 14].min
    (0..limit).each do |i|
      path = paths[i]
      detail += (@format_string % path)
      detail += "\n"
    end
    if limit < paths.length - 1
      detail += " - Plus #{(paths.length - 1) - limit} more files."
    end

    return detail
  end
  
  def is_configured?(files)
    return true
  end
  
end