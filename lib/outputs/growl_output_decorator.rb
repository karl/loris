class GrowlOutputDecorator
  
  def initialize(output, growler)
    @output = output
    @growler = growler
  end
  
  def start_run()
    @output.start_run()
  end

  def add_result(result)
    icon = get_icon(result[:state])

    if @growler.installed?
      @growler.notify {
        self.title = result[:title] + (result[:summary].nil? ? '' : ' - ' + result[:summary])
        self.message = result[:first]
        self.image = icon
      }
    end
    
    @output.add_result result
  end
  
  def get_icon(state)
    return File.join(File.expand_path(File.dirname(__FILE__)), '..', 'icons', "#{state.to_s}.png")
  end
  
end