class JsTestDriverServer
  
  def initialize(config, pinger, process, jar, browser, sleep_time)
    @config = config
    @pinger = pinger
    @process = process
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
    @process.create(command)
    sleep @sleep_time
  end
  
end