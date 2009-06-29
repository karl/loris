require 'rubygems'
require 'bind'
require 'rbconfig'
require 'find'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'file_finder'
require 'output_action'
require 'poller'
require 'sleep_waiter'
require 'always_continuer'
require 'file_actioner'


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

          w = SleepWaiter.new(0.1)
          c = AlwaysContinuer.new
          ff = FileFinder.new(Find, dir)
          ao = OutputAction.new($stdout, "'%s' modified!")
          a = FileActioner.new(ff, ao)          
          p = Poller.new(w, c, a)
          
          
          obs = DebugObserver.new
          
          p.add_observer(obs)
          
          p.start()

        end
      end    

    end
    
  end
  
end