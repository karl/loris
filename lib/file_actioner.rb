class FileActioner
  
  def initialize(file_finder, task_manager)
    @file_finder = file_finder
    @task_manager = task_manager
    
    @prev_all_files = []
  end
  
  def run
    files = @file_finder.find
    
    # Refactor this to the file_finder class
    changes = (files[:all] - @prev_all_files) | (@prev_all_files - files[:all])
    files[:filtered] = files[:filtered] | changes
    
    if (files[:filtered] != [])
      @task_manager.run(files)
    end
    
    @prev_all_files = files[:all]
  end
  
end