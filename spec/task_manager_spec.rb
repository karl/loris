require 'lib/task_manager.rb'

describe TaskManager do

  before do
    @files = ['/path/to.file']
    @result = {
      :state => :success,
      :detail =>'task output'
    }

    @task1 = mock('Task 1')
    @task2 = mock('Task 2')
    @output = mock('Output')

  end

  it "should output an run task" do
    @task1.should_receive(:run).with(@files).and_return(@result)
    @output.should_receive(:add_result).with(@result)

    task_manager = TaskManager.new(@output)
    task_manager.add(@task1)
    task_manager.run(@files)
  end

  it "should run multiple tasks in order added" do
    @task1.should_receive(:run).ordered.with(@files).and_return(@result)
    @task2.should_receive(:run).ordered.with(@files).and_return(@result)
    @output.should_receive(:add_result).any_number_of_times

    task_manager = TaskManager.new(@output)
    task_manager.add(@task1)
    task_manager.add(@task2)
    task_manager.run(@files)
  end

  it "should stop running tasks on error state" do
    @task1.should_receive(:run).ordered.with(@files).and_return({:state => :error})
    @output.should_receive(:add_result).any_number_of_times

    task_manager = TaskManager.new(@output)
    task_manager.add(@task1)
    task_manager.add(@task2)
    task_manager.run(@files)
  end

  it "should stop running tasks on failure state" do
    @task1.should_receive(:run).ordered.with(@files).and_return({:state => :failure})
    @output.should_receive(:add_result).any_number_of_times

    task_manager = TaskManager.new(@output)
    task_manager.add(@task1)
    task_manager.add(@task2)
    task_manager.run(@files)
  end

end


