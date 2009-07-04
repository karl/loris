class GrowlOutputDecorator
  
  def initialize(output, growler)
    @output = output
    @growler = growler
  end
  
  def add_result(result)
    icon = get_icon(result[:state])
    puts icon

    @growler.notify {
      self.title = result[:title]
      self.message = result[:summary]
      self.image = icon
    }
    
    @output.add_result result
  end
  
  def get_icon(state)
    return File.join File.expand_path(File.dirname(__FILE__)), 'icons', "#{state.to_s}.png"
  end
  
end