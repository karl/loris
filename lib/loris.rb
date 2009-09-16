$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'bind'
require 'rbconfig'
require 'find'
require 'Growl'


require 'file_finder'
require 'poller'
require 'sleep_waiter'
require 'always_continuer'
require 'file_actioner'
require 'modified_filter'
require 'file_filter'
require 'task_manager'
require 'extension_filter'

require 'outputs/output_collection'
require 'outputs/shell_output'
require 'outputs/windows_console_clearing_output' 
require 'outputs/unix_console_clearing_output' 
require 'outputs/growl_output'

require 'tasks/list_task'
require 'tasks/jspec_task'
require 'tasks/jspec_runner'
require 'tasks/javascript_lint_task'
require 'tasks/javascript_lint_runner'


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
    
      class DummyActioner
        
        def initialize(actioner, stream)
          @actioner = actioner
          @stream = stream
        end
        
        def run()
            @actioner.run()
            @stream.puts '[Poll complete]'
            @stream.flush
        end
        
      end
    
      class << self
        def execute(args)
          
          # Get config variables
          debug = args.length > 0
          is_windows = RUBY_PLATFORM =~ /mswin32/
          dir = Dir.pwd
          sleep_duration = 1

          # Create object graph
          w = SleepWaiter.new(sleep_duration)
          c = AlwaysContinuer.new
          ff = FileFinder.new(Find, dir)
          ff.add_filter(FileFilter.new(File))
          ff.add_filter(ModifiedFilter.new(File))

          cco = is_windows ? WindowsConsoleClearingOutput.new() : UnixConsoleClearingOutput.new()

          oc = OutputCollection.new()
          oc.add(ShellOutput.new($stdout))
          oc.add(cco)
          oc.add(GrowlOutput.new(Growl)) unless debug       
          
          tm = TaskManager.new(oc)
          tm.add(ListTask.new()) if debug
          tm.add(JavascriptLintTask.new(JavascriptLintRunner.new(dir), dir))
          tm.add(JSpecTask.new(JSpecRunner.new(dir)))

          a = FileActioner.new(ff, tm)    
          
          da = DummyActioner.new(a, $stdout)
                
          p = Poller.new(w, c, debug ? da : a)
          
          p.start()

        end
      end    

    end
    
  end
  
end