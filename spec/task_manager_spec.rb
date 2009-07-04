require 'lib/task_manager.rb'

describe TaskManager do

  it "should output an run task" do
    files = ['/path/to.file']
    result = {
      :detail =>'task output'
    }
    
    task = mock('Task')
    output = mock('Output')

    task.should_receive(:run).with(files).and_return(result)
    output.should_receive(:add_result).with(result)

    task_manager = TaskManager.new(output)
    task_manager.add(task)
    task_manager.run(files)
  end

  it "should run multiple tasks in order added" do
    files = ['/path/to.file']

    task1 = mock('Task 1')
    task2 = mock('Task 2')
    output = mock('Output')
    output.should_receive(:add_result).any_number_of_times

    task1.should_receive(:run).ordered.with(files).and_return({})
    task2.should_receive(:run).ordered.with(files).and_return({})

    task_manager = TaskManager.new(output)
    task_manager.add(task1)
    task_manager.add(task2)
    task_manager.run(files)
  end

end


