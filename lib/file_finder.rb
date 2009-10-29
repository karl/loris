class FileFinder
  
  def initialize(finder, dir)
    @finder = finder
    @dir = dir
    @filters = []
  end
  
  def add_filter(filter)
    @filters << filter
  end
  
  def find
    
    # Refactor in detecting changes from previous all files list
    # Refactor in ability to ignore certain dirs/files (.svn etc)
    # Refactor detecting modified files
    
    all_files = []
    filtered_files = []

    @finder.find(@dir) do |path|
      all_files << path
      
      keep = @filters.inject(true) { |k, filter| k && filter.filter(path)  }
      filtered_files << path if keep
    end
    
    @filters.each do |filter|
      filter.complete
    end

    return { :all => all_files, :filtered => filtered_files }
  end

end