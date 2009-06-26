class ModifiedFilter
  
  def initialize(file_class)
    @file_class = file_class
  end
  
  def filter(path)
    return @last_modified.nil? || @file_class.mtime(path) > @last_modified
  end
  
  def set_last_modified(time)
    @last_modified = time
  end
  
end