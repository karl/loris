class TaskManager
 
  def initialize(output)
    @output = output
    @tasks = []
  end
  
  def add(task)
    @tasks << task
  end
  
  def run(files)
    @num_tasks_run = 0
    
    @tasks.each do |task|
      
      begin
        break if !run_task(files, task)        
      rescue Exception => ex
        output_exception(ex)
      end
      
    end
    
  end
  
  def run_task(files, task)
    result = task.run(files)
    return true if result.nil?

    task_run
    
    @output.add_result(result) 
    return !([:error, :failure].include? result[:state])
  end
  
  def task_run
    @num_tasks_run += 1
    if (@num_tasks_run == 1) 
      @output.start_run
    end  
  end
  
  def output_exception(ex)
    @output.add_result({
      :state => :error,
      :title => 'Task',
      :summary => 'Exception',
      :first => ex.message,
      :detail => ex.backtrace
    })
  end
  
end