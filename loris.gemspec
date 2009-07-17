# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{loris}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Karl O'Keeffe"]
  s.date = %q{2009-07-12}
  s.description = %q{Automatically run tasks on file system changes (unit tests, acceptance tests, etc)}
  s.email = ["loris@monket.net"]
  s.extra_rdoc_files = ["README.rdoc"]
  
  s.files = ["README.rdoc", "loris.gemspec"] + Dir['bin/*'] + Dir['lib/**/*'] + Dir['spec/**/*.rb']
  s.default_executable = %q{loris}
  s.executables = ["loris"]

  s.homepage = %q{http://wiki.github.com/karl/loris}
  s.post_install_message = %q{
Loris Installed!
}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{loris}
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Automatically run tasks on file system changes (unit tests, acceptance tests, etc)}

  s.add_dependency(%q<visionmedia-bind>, [">= 0.2.6"])
  s.add_dependency(%q<karl-growl>, [">= 1.0.3"])
  
  # javascript lint
  # jspec
end
