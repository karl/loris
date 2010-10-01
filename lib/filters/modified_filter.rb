class ModifiedFilter
  
  def initialize(file_class, last_modified = nil)
    @file_class = file_class
    @last_modified = last_modified
    @modifieds = []
    @prev_file_sizes = {}
  end
  
  def filter(path)
    modified = @file_class.mtime(path)
    @modifieds << modified
    
    file_size = @file_class.size(path)
    prev_file_size = @prev_file_sizes[path]
    modified = @last_modified.nil? || modified > @last_modified || prev_file_size.nil? || file_size != prev_file_size
    
    @prev_file_sizes[path] = file_size
    
    return modified
  end
  
  def complete
    @last_modified = @modifieds.max
    @modifieds = []
  end
  
end