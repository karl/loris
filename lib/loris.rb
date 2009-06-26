require 'rubygems'
require 'bind'
require 'rbconfig'
include Config

module Loris
  BINARY = File.expand_path(File.dirname(__FILE__) + '/../bin/loris')
  LIBDIR = File.expand_path(File.dirname(__FILE__) + '/../lib')
  RUBY_BINARY = File.join(Config::CONFIG['bindir'], Config::CONFIG['ruby_install_name'])  
  
  module CLI
    
    class Main
    
      class << self
        def execute(args)
          puts 'Loris is running!'

          

        end
      end    

    end
    
  end
  
  class Test
    
    def hello
      return 'Hello'
    end
    
  end
  
end