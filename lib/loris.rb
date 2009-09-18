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
require 'task_manager'

require 'filters/extension_filter'
require 'filters/modified_filter'
require 'filters/file_filter'
require 'filters/ends_with_filter'

require 'outputs/output_collection'
require 'outputs/shell_output'
require 'outputs/windows_console_clearing_output' 
require 'outputs/unix_console_clearing_output' 
require 'outputs/growl_output'

require 'tasks/list_task'
require 'tasks/jspec/jspec_task'
require 'tasks/jspec/jspec_runner'
require 'tasks/javascript_lint/javascript_lint_task'
require 'tasks/javascript_lint/javascript_lint_runner'
require 'tasks/js_test_driver/js_test_driver_task'
require 'tasks/js_test_driver/js_test_driver_runner'
require 'tasks/rspec/rspec_task'
require 'tasks/rspec/rspec_runner'


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
          jstd_jar = File.join(LIBDIR, 'JsTestDriver-1.0b.jar')

          # Create object graph
          w = SleepWaiter.new(sleep_duration)
          c = AlwaysContinuer.new
          ff = FileFinder.new(Find, dir)
          ff.add_filter(FileFilter.new(File))
          ff.add_filter(ModifiedFilter.new(File))

          cco = is_windows ? WindowsConsoleClearingOutput.new() : UnixConsoleClearingOutput.new()

          oc = OutputCollection.new()
          oc.add(ShellOutput.new($stdout))
          oc.add(cco) unless debug
          oc.add(GrowlOutput.new(Growl)) unless debug       
          
          tm = TaskManager.new(oc)
          tm.add(ListTask.new()) if debug
          tm.add(JavascriptLintTask.new(JavascriptLintRunner.new(dir, ExtensionFilter.new(File, 'js')), dir))
          tm.add(JSpecTask.new(JSpecRunner.new(dir, ExtensionFilter.new(File, 'js'))))
          tm.add(JsTestDriverTask.new(JsTestDriverRunner.new(dir, jstd_jar, ExtensionFilter.new(File, 'js'))))
          tm.add(RSpecTask.new(RSpecRunner.new(dir, ExtensionFilter.new(File, 'rb'), EndsWithFilter.new('_spec.rb'))))

          a = FileActioner.new(ff, tm)    
          
          da = DummyActioner.new(a, $stdout)
                
          p = Poller.new(w, c, debug ? da : a)
          
          # Start!
          p.start()

        end
      end    

    end
    
  end
  
end