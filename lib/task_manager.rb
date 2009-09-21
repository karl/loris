class TaskManager
 
  def initialize(output)
    @output = output
    @tasks = []
  end
  
  def add(task)
    @tasks << task
  end
  
  def run(files)
    @output.start_run;

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
      
    @output.add_result(result) 
    return !([:error, :failure].include? result[:state])
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