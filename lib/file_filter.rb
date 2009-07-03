class FileFilter
  
  def initialize(file_class)
    @file_class = file_class
  end
  
  def filter(path)
    return @file_class.file?(path)
  end
  
  def complete()
  end
  
end