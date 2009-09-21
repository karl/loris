class ModifiedFilter
  
  def initialize(file_class, last_modified = nil)
    @file_class = file_class
    @last_modified = last_modified
    @modifieds = []
  end
  
  def filter(path)
    modified = @file_class.mtime(path)
    @modifieds << modified
    
    return @last_modified.nil? || modified > @last_modified
  end
  
  def complete
    @last_modified = @modifieds.max
    @modifieds = []
  end
  
end