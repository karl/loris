class FileActioner
  
  def initialize(file_finder, task_manager)
    @file_finder = file_finder
    @task_manager = task_manager
    
    @prev_all_files = []
  end
  
  def run
    begin
      num_tasks_run = 0
      files = @file_finder.find
    
      # Refactor this to the file_finder class
      changes = (files[:all] - @prev_all_files) | (@prev_all_files - files[:all])
      files[:filtered] = files[:filtered] | changes
    
      if (files[:filtered] != [])
        num_tasks_run = @task_manager.run(files)
      end
    
      @prev_all_files = files[:all]
    rescue Exception => e
      @task_manager.output_exception(e);
    end
      
    num_tasks_run > 0
  end
  
end