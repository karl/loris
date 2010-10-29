$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'bind'
require 'rbconfig'
require 'find'
require 'Growl'
require 'yaml'
require 'json'
require 'uri'


require 'file_finder'
require 'poller'
require 'sleep_waiter'
require 'always_continuer'
require 'file_actioner'
require 'task_manager'
require 'pinger'

require 'directory_finder'

require 'filters/extension_filter'
require 'filters/modified_filter'
require 'filters/file_filter'
require 'filters/ends_with_filter'
require 'filters/starts_with_filter'

require 'outputs/output_collection'
require 'outputs/shell_output'
require 'outputs/windows_console_clearing_output'
require 'outputs/unix_console_clearing_output'
require 'outputs/growl_output'

require 'tasks/list_task'
require 'tasks/command_line_task'
require 'tasks/jspec/jspec_runner'
require 'tasks/jspec/jspec_parser'
require 'tasks/coffeescript/coffeescript_runner'
require 'tasks/coffeescript/coffeescript_parser'
require 'tasks/javascript_lint/javascript_lint_runner'
require 'tasks/javascript_lint/javascript_lint_parser'
require 'tasks/google_lint/google_lint_runner'
require 'tasks/google_lint/google_lint_config'
require 'tasks/google_lint/google_lint_parser'
require 'tasks/jasmine_node/jasmine_node_config'
require 'tasks/jasmine_node/jasmine_node_runner'
require 'tasks/jasmine_node/jasmine_node_parser'
require 'tasks/jasmine_node_coverage/jasmine_node_coverage_runner'
require 'tasks/jasmine_node_coverage/js_coverage'
require 'tasks/rspec/rspec_runner'
require 'tasks/rspec/rspec_parser'
require 'tasks/closure_compiler/closure_compiler_config'
require 'tasks/closure_compiler/closure_compiler_runner'
require 'tasks/closure_compiler/closure_compiler_parser'


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

        def run
            @actioner.run
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
          browser = is_windows ? 'C:/Program Files/Internet Explorer/iexplore.exe' : 'open'

          # Create object graph
          w = SleepWaiter.new(sleep_duration)
          c = AlwaysContinuer.new
          ff = FileFinder.new(Find, dir)
          ff.add_filter(FileFilter.new(File))
          ff.add_filter(ModifiedFilter.new(File))

          cco = is_windows ? WindowsConsoleClearingOutput.new : UnixConsoleClearingOutput.new

          oc = OutputCollection.new
          oc.add(ShellOutput.new($stdout))
          oc.add(cco) unless debug
          oc.add(GrowlOutput.new(Growl)) unless debug

          tm = TaskManager.new(oc)
          tm.add(ListTask.new) if debug
          tm.add(coffeescript_task(dir))
          tm.add(javascript_lint_task(dir))
          tm.add(google_lint_task(dir))
          tm.add(jasmine_node_task(dir))
          # tm.add(jasmine_node_coverage_task(dir))
          tm.add(CommandLineTask.new(JSpecRunner.new(dir, ExtensionFilter.new(File, 'js')), JSpecParser.new)) unless is_windows
          tm.add(jsTestDriverTask(dir))
          tm.add(CommandLineTask.new(RSpecRunner.new(dir, ExtensionFilter.new(File, 'rb'), EndsWithFilter.new('_spec.rb')), RSpecParser.new))
          tm.add(closure_compiler_task(dir))

          a = FileActioner.new(ff, tm)

          da = DummyActioner.new(a, $stdout)

          p = Poller.new(w, c, debug ? da : a)

          # Start!
          p.start

        end

        def coffeescript_task(dir)
          return CommandLineTask.new(
            CoffeeScriptRunner.new(
              'coffee',
              dir,
              ExtensionFilter.new(File, 'coffee'),
              DirectoryFinder.new(File, StartsWithFilter.new('coffee-'))
            ),
            CoffeeScriptParser.new(dir)
          )
        end

        def jasmine_node_task(dir)
          node = '/usr/local/bin/node'
          spec_dir = File.join(LIBDIR, 'jasmine-node')

          return CommandLineTask.new(
            JasmineNodeRunner.new(
              node,
              spec_dir,
              dir,
              ExtensionFilter.new(File, 'js'),
              JasmineNodeConfig.new(dir, JSON, File)
            ),
            JasmineNodeParser.new(dir)
          )
        end

        def jasmine_node_coverage_task(dir)
          node = '/usr/local/bin/node'
          spec_dir = File.join(LIBDIR, 'jasmine-node')

          return CommandLineTask.new(
            JasmineNodeCoverageRunner.new(
              JasmineNodeRunner.new(
                node,
                spec_dir,
                dir,
                ExtensionFilter.new(File, 'js'),
                JasmineNodeConfig.new(dir, JSON, File)
              ),
              JsCoverage.new("node-jscoverage"),
              JasmineNodeConfig.new(dir, JSON, File)
            ),
            JasmineNodeParser.new(dir)
          )
        end

        # Refactor into factory
        def javascript_lint_task(dir)
          is_windows = RUBY_PLATFORM =~ /mswin32/
          binary = File.join(LIBDIR, 'javascript-lint' , is_windows ? 'jsl.exe' : 'jsl')

          return CommandLineTask.new(
            JavascriptLintRunner.new(
              binary,
              dir,
              ExtensionFilter.new(File, 'js')
            ),
            JavascriptLintParser.new(dir)
          )
        end

        def google_lint_task(dir)
          binary = File.join(LIBDIR, 'google-lint' , 'gjslint')
          fix_style_binary = File.join(LIBDIR, 'google-lint' , 'fixjsstyle')

          return CommandLineTask.new(
            GoogleLintRunner.new(
              binary,
              fix_style_binary,
              dir,
              ExtensionFilter.new(File, 'js'),
              GoogleLintConfig.new(
                dir,
                YAML,
                URI
              )
            ),
            GoogleLintParser.new(dir)
          )
        end

        def closure_compiler_task(dir)
          jar = File.join(LIBDIR, 'closure-compiler' , 'closure-compiler.jar')

          return CommandLineTask.new(
            ClosureCompilerRunner.new(
              jar,
              dir,
              ExtensionFilter.new(File, 'js'),
              ClosureCompilerConfig.new(
                dir,
                YAML,
                URI
              )
            ),
            ClosureCompilerParser.new(dir)
          )
        end


        # Will need to be refactored into a factory
        def jsTestDriverTask(dir)
          require 'tasks/js_test_driver/js_test_driver_runner'
          require 'tasks/js_test_driver/js_test_driver_parser'
          require 'tasks/js_test_driver/js_test_driver_config'
          require 'tasks/js_test_driver/js_test_driver_server'

          jar = File.join(LIBDIR, 'js-test-driver/JsTestDriver-1.2.jar')
          is_windows = RUBY_PLATFORM =~ /mswin32/

          if is_windows
            require 'browser_finder'
            browser = BrowserFinder.new.getDefault
          else
            browser = 'open "%1"'
          end

          sleep_time = 3

          if is_windows
            require 'windows_process'
          else
            require 'unix_process'
          end

          return CommandLineTask.new(
            JsTestDriverRunner.new(
              dir,
              jar,
              ExtensionFilter.new(File, 'js'),
              JsTestDriverServer.new(
                JsTestDriverConfig.new(
                  dir,
                  YAML,
                  URI
                ),
                Pinger.new,
                is_windows ? WindowsProcess.new : UnixProcess.new,
                jar,
                browser,
                sleep_time
              )
            ),
            JsTestDriverParser.new
          )
        end

      end

    end

  end

end