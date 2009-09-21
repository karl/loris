class JsTestDriverServer
  
  def initialize(config, pinger, jar, browser, sleep_time)
    @config = config
    @pinger = pinger
    @jar = jar
    @browser = browser
    @sleep_time = sleep_time
  end
  
  def start_if_required
    @config.reload
    
    if @config.host == 'localhost' && server_not_running
      start_server(@config.port)
    end
  end
  
  def server_not_running
    return !@pinger.is_port_open?('127.0.0.1', @config.port)
  end
  
  def start_server(port)
    command = "java -jar \"#{@jar}\" --port #{port} --browser \"#{@browser}\" "
    
    
    is_windows = RUBY_PLATFORM =~ /mswin32/
    
    if is_windows
      require 'win32/process'
      puts command
      exec(command) if Process.fork.nil?
    else
      exec(command) if fork.nil?
    end
    
    sleep @sleep_time
  end
  
end