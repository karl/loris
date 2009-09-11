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

require 'outputs/shell_output'
require 'outputs/clearing_output_decorator' 
require 'outputs/growl_output_decorator'

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
          puts 'Loris is running!'

          debug = args.length > 0

          dir = Dir.pwd

          w = SleepWaiter.new(1)
          c = AlwaysContinuer.new
          ff = FileFinder.new(Find, dir)
          ff.add_filter(FileFilter.new(File))
          ff.add_filter(ModifiedFilter.new(File))

          so = ShellOutput.new($stdout)
          co = ClearingOutputDecorator.new(so)

          growler = Growl
          go = GrowlOutputDecorator.new(co, growler)          
          
          tm = TaskManager.new(debug ? co : go)
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