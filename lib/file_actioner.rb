class FileActioner
  
  def initialize(file_finder, task_manager)
    @file_finder = file_finder
    @task_manager = task_manager
  end
  
  def run
    files = @file_finder.get_filtered_files
    if files != []
      @task_manager.run(files)
    end
  end
  
end