class TaskManager
 
  def initialize(output)
    @output = output
    @tasks = []
  end
  
  def add(task)
    @tasks << task
  end
  
  def run(modified_files)
    @output.puts 'Task manager:'
    @tasks.each do |task|
      @output.puts task.run(modified_files)
    end
  end
  
end