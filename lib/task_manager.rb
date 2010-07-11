class TaskManager
 
  def initialize(output)
    @output = output
    @tasks = []
    @fail_index = -1
  end
  
  def add(task)
    @tasks << task
  end
  
  def run(files)
    @num_tasks_run = 0
    
    @tasks.each_index do |index|
      task = @tasks[index]

      # Don't run if this task is after the last failed task
      if @fail_index >= 0 && @fail_index < index
        @output.add_result(@fail_result)
        break
      end
      
      result = nil
      begin
        result = run_task(files, task)        
      rescue Exception => ex
        result = build_exception_result ex
        @output.add_result result
      end

      next if result.nil?

      if [:error, :failure].include? result[:state]
        # Remember this task as the one that failed
        # And end this current run of tasks
        @fail_index = index
        @fail_result = result
        
        @fail_result[:state] = :error
        @fail_result[:title] = 'Fix ' + @fail_result[:title] + ' to run other tasks'
        break
      elsif result[:state] == :success
        # reset fail index
        @fail_index = -1 if index == @fail_index
      end
      
    end
    
  end
  
  def run_task(files, task)
    result = task.run(files)
    return result if result.nil?

    task_run
    
    @output.add_result(result) 
    return result
  end
  
  def task_run
    @num_tasks_run += 1
    if (@num_tasks_run == 1) 
      @output.start_run
    end  
  end
  
  def build_exception_result(ex)
    return {
      :state => :error,
      :title => 'Task',
      :summary => 'Exception',
      :first => ex.message,
      :detail => ex.backtrace
    }
  end
  
  def output_exception(ex)
    @output.add_result build_exception_result ex
  end
  
end