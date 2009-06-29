class FileActioner
  
  def initialize(file_finder, action)
    @file_finder = file_finder
    @action = action
  end
  
  def action
    @action.action(@file_finder.get_filtered_files)
  end
  
end