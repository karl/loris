class TaskManager
 
  def initialize(output)
    @output = output
    @tasks = []
  end
  
  def add(task)
    @tasks << task
  end
  
  def run(files)

    @tasks.each do |task|
      
      result = task.run(files)
      if !result.nil?
        @output.add_result(result) 
        break if [:error, :failure].include? result[:state]
      end
      
    end

  end
  
end