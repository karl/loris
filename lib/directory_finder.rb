class DirectoryFinder
  
  def initialize(file, filter)
    @file = file
    @filter = filter
  end
  
  def find(files)
    dirs = []
    
    files.each do |file_name|
      dir = @file.dirname file_name
      dirs << dir if @filter.filter(File.basename(dir))
    end
    
    return dirs
  end
  
  def complete
  end
  
end