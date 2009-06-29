class FileFinder
  
  def initialize(finder, dir)
    @finder = finder
    @dir = dir
    @filters = []
  end
  
  def add_filter(filter)
    @filters << filter
  end
  
  def get_filtered_files
    files = []

    @finder.find(@dir) do |path|
      keep = @filters.inject(true) { |k, filter| k && filter.filter(path)  }
      files << path if keep
    end
    
    @filters.each do |filter|
      filter.complete
    end

    return files
  end
  
end