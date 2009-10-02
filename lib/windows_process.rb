require 'win32/process'

class WindowsProcess

  def create(command)
    puts command
    Process.create({
      :app_name => command
    })
  end
  
end