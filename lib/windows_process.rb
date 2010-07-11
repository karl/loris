begin
  require 'win32/process'
rescue LoadError
  warn "You must 'gem install win32-process to run Loris on Windows"
  exit 1
end

class WindowsProcess

  def create(command)
    Process.create({
      :app_name => command
    })
  end
  
end