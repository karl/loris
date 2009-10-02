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
      start_and_capture_browser(@config.port)
    end
  end
  
  def server_not_running
    return !@pinger.is_port_open?('127.0.0.1', @config.port)
  end
  
  def start_server(port)
    command = "java -jar \"#{@jar}\" --port #{port}" #" --browser \"#{@browser}\" "
    @process.create(command)
    sleep @sleep_time
  end
  
  def start_and_capture_browser(port)
    capture_url = "http://localhost:#{port}/capture"
    command = @browser.gsub('%1', capture_url)
    @process.create(command)
    sleep @sleep_time
  end
  
end