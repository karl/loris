class CoffeeScriptParser
 
  def initialize(dir)
    @dir = dir

    # TODO: Tidy!
    if (RUBY_PLATFORM =~ /mswin32/)
      @dir = @dir.gsub('/', '\\')
    end 
  end
  
  def parse_result(detail)
    if (detail.strip == '')
      return :success, 'All files compiled', ''
    end
    
    summary_line = detail.grep( /^In .*/ )[0]

    if summary_line.nil?
      # error
      error_info = (detail + "\nUnknown Error!").to_a[0].strip
      return :error, 'Error', error_info
    end
    
    return :failure, 'Failed to compile', strip_dir(summary_line[3..-1].strip)
  end

  def strip_dir(text)

    # Move to function/class w/ win32 related code
    if (text[0, @dir.length] == @dir)
      text = text[(@dir.length + 1)..-1]
    end    
    
  end
  
end