$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'bind'
require 'rbconfig'
require 'find'

require 'file_finder'
require 'list_task'
require 'poller'
require 'sleep_waiter'
require 'always_continuer'
require 'file_actioner'
require 'modified_filter'
require 'file_filter'
require 'jspec_task'
require 'task_manager'
require 'shell_output'
require 'growl_output_decorator'
require 'Growl'


include Config

class DebugObserver
  def update
    puts '[Poll complete]'
  end
end


module Loris
  BINARY = File.expand_path(File.dirname(__FILE__) + '/../bin/loris')
  LIBDIR = File.expand_path(File.dirname(__FILE__) + '/../lib')
  RUBY_BINARY = File.join(Config::CONFIG['bindir'], Config::CONFIG['ruby_install_name'])  
  
  module CLI
    
    class Main
    
      class << self
        def execute(args)
          puts 'Loris is running!'

          dir = Dir.pwd

          w = SleepWaiter.new(1)
          c = AlwaysContinuer.new
          ff = FileFinder.new(Find, dir)
          ff.add_filter(ModifiedFilter.new(File))
          ff.add_filter(FileFilter.new(File))

          growler = Growl
          tm = TaskManager.new(GrowlOutputDecorator.new(ShellOutput.new($stdout), growler))
          tm.add(ListTask.new())
          tm.add(JSpecTask.new())

          a = FileActioner.new(ff, tm)          
          p = Poller.new(w, c, a)
          
          
          #obs = DebugObserver.new
          #p.add_observer(obs)

          
          
          p.start()

        end
      end    

    end
    
  end
  
end