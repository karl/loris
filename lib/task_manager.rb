class TaskManager
 
  def initialize(output)
    @output = output
    @tasks = []
  end
  
  def add(task)
    @tasks << task
  end
  
  def run(modified_files)
    @tasks.each do |task|
      result = task.run(modified_files)
      @output.add_result(result)
    end
  end
  
end