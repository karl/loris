# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{loris}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Karl O'Keeffe"]
  s.date = %q{2011-06-15}
  s.default_executable = %q{loris}
  s.description = %q{Automatically run javascript unit tests}
  s.email = %q{loris@monket.net}
  s.executables = ["loris"]
  s.extra_rdoc_files = [
    "README.rdoc",
    "TODO"
  ]
  s.files = [
    "README.rdoc",
    "Rakefile",
    "TODO",
    "VERSION",
    "bin/loris",
    "cucumber.yml",
    "examples/self_test/jsl.conf",
    "examples/self_test/spec/spec.rhino.js",
    "features/javascript_lint.feature",
    "features/run.feature",
    "features/step_definitons/all.rb",
    "features/support/env.rb",
    "lib/always_continuer.rb",
    "lib/browser_finder.rb",
    "lib/closure-compiler/closure-compiler.jar",
    "lib/directory_finder.rb",
    "lib/file_actioner.rb",
    "lib/file_finder.rb",
    "lib/filters/ends_with_filter.rb",
    "lib/filters/extension_filter.rb",
    "lib/filters/file_filter.rb",
    "lib/filters/modified_filter.rb",
    "lib/filters/starts_with_filter.rb",
    "lib/google-lint/fixjsstyle",
    "lib/google-lint/gjslint",
    "lib/icons/error.png",
    "lib/icons/failure.png",
    "lib/icons/info.png",
    "lib/icons/success.png",
    "lib/icons/warning.png",
    "lib/jasmine-node/LICENSE",
    "lib/jasmine-node/lib/jasmine/index.js",
    "lib/jasmine-node/lib/jasmine/jasmine-0.10.2.js",
    "lib/jasmine-node/specs.js",
    "lib/javascript-lint/jsl",
    "lib/javascript-lint/jsl.exe",
    "lib/js-test-driver/JsTestDriver-1.2.jar",
    "lib/js-test-driver/JsTestDriver-1.3.2.jar",
    "lib/js-test-driver/plugins/coverage-1.3.2.jar",
    "lib/loris.rb",
    "lib/outputs/growl_output.rb",
    "lib/outputs/output_collection.rb",
    "lib/outputs/shell_output.rb",
    "lib/outputs/unix_console_clearing_output.rb",
    "lib/outputs/windows_console_clearing_output.rb",
    "lib/pinger.rb",
    "lib/poller.rb",
    "lib/sleep_waiter.rb",
    "lib/task_manager.rb",
    "lib/tasks/closure_compiler/closure_compiler_config.rb",
    "lib/tasks/closure_compiler/closure_compiler_parser.rb",
    "lib/tasks/closure_compiler/closure_compiler_runner.rb",
    "lib/tasks/coffeescript/coffeescript_parser.rb",
    "lib/tasks/coffeescript/coffeescript_runner.rb",
    "lib/tasks/command_line_task.rb",
    "lib/tasks/google_lint/google_lint_config.rb",
    "lib/tasks/google_lint/google_lint_parser.rb",
    "lib/tasks/google_lint/google_lint_runner.rb",
    "lib/tasks/jasmine_ci/jasmine_ci_parser.rb",
    "lib/tasks/jasmine_ci/jasmine_ci_runner.rb",
    "lib/tasks/jasmine_node/jasmine_node_config.rb",
    "lib/tasks/jasmine_node/jasmine_node_parser.rb",
    "lib/tasks/jasmine_node/jasmine_node_runner.rb",
    "lib/tasks/jasmine_node_coverage/jasmine_node_coverage_runner.rb",
    "lib/tasks/jasmine_node_coverage/js_coverage.rb",
    "lib/tasks/javascript_lint/javascript_lint_parser.rb",
    "lib/tasks/javascript_lint/javascript_lint_runner.rb",
    "lib/tasks/js_test_driver/js_test_driver_config.rb",
    "lib/tasks/js_test_driver/js_test_driver_parser.rb",
    "lib/tasks/js_test_driver/js_test_driver_runner.rb",
    "lib/tasks/js_test_driver/js_test_driver_server.rb",
    "lib/tasks/jspec/jspec_parser.rb",
    "lib/tasks/jspec/jspec_runner.rb",
    "lib/tasks/list_task.rb",
    "lib/tasks/rspec/rspec_parser.rb",
    "lib/tasks/rspec/rspec_runner.rb",
    "lib/unix_process.rb",
    "lib/windows_process.rb",
    "loris.gemspec",
    "loris.tmproj",
    "spec/file_actioner_spec.rb",
    "spec/file_finder_spec.rb",
    "spec/filters/ends_with_filter_spec.rb",
    "spec/filters/file_filter_spec.rb",
    "spec/filters/modified_filter_spec.rb",
    "spec/growl_output_spec.rb",
    "spec/list_task_spec.rb",
    "spec/poller_spec.rb",
    "spec/shell_output_spec.rb",
    "spec/task_manager_spec.rb",
    "spec/tasks/javascript_lint/javascript_lint_runner_spec.rb",
    "spec/tasks/js_test_driver/js_test_driver_runner_spec.rb",
    "spec/tasks/jspec/jspec_parser_spec.rb",
    "spec/tasks/jspec/jspec_runner_spec.rb"
  ]
  s.homepage = %q{http://github.com/karl/loris}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Automatically run javascript unit tests}
  s.test_files = [
    "spec/file_actioner_spec.rb",
    "spec/file_finder_spec.rb",
    "spec/filters/ends_with_filter_spec.rb",
    "spec/filters/file_filter_spec.rb",
    "spec/filters/modified_filter_spec.rb",
    "spec/growl_output_spec.rb",
    "spec/list_task_spec.rb",
    "spec/poller_spec.rb",
    "spec/shell_output_spec.rb",
    "spec/task_manager_spec.rb",
    "spec/tasks/javascript_lint/javascript_lint_runner_spec.rb",
    "spec/tasks/js_test_driver/js_test_driver_runner_spec.rb",
    "spec/tasks/jspec/jspec_parser_spec.rb",
    "spec/tasks/jspec/jspec_runner_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 1.4.3"])
      s.add_runtime_dependency(%q<bind>, [">= 0.2.6"])
      s.add_runtime_dependency(%q<karl-growl>, [">= 1.0.6"])
      s.add_runtime_dependency(%q<extensions>, [">= 0.6.0"])
    else
      s.add_dependency(%q<json>, [">= 1.4.3"])
      s.add_dependency(%q<bind>, [">= 0.2.6"])
      s.add_dependency(%q<karl-growl>, [">= 1.0.6"])
      s.add_dependency(%q<extensions>, [">= 0.6.0"])
    end
  else
    s.add_dependency(%q<json>, [">= 1.4.3"])
    s.add_dependency(%q<bind>, [">= 0.2.6"])
    s.add_dependency(%q<karl-growl>, [">= 1.0.6"])
    s.add_dependency(%q<extensions>, [">= 0.6.0"])
  end
end

