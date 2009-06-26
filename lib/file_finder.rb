class FileFinder
  
  def initialize(finder)
    @finder = finder
    @filters = []
  end
  
  def add_filter(filter)
    @filters << filter
  end
  
  def get_filtered_files(directory)
    files = []

    @finder.find(directory) do |path|
      keep = @filters.inject(true) { |k, filter| k && filter.filter(path)  }
      files << path if keep
    end

    return files
  end
  
end