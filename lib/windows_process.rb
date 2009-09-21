require 'win32/process'

class WindowsProcess

  def create(command)
    exec(command) if Process.fork.nil?
  end
  
end