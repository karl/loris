class JavascriptLintParser
 
  def initialize(dir)
    @dir = dir
 
    # TODO: Tidy!
    if (RUBY_PLATFORM =~ /mswin32/)
      @dir = @dir.gsub('/', '\\')
    end 
  end
  
  def parse_result(detail)
    summary_line = detail.grep( /\d+\s+error.*,\s+\d+\s+warning.*/ )[0]
    
    if summary_line.nil?
      # error
      error_info = (detail + "\nUnknown Error!").to_a[0].strip
      return :error, 'Error', error_info
    end
    
    if summary_line =~ /([1-9]+)\d*\s+error/
      num_failures = $1
      error_info = detail.grep(/\([0-9]+\):([^:]*)Error:/)[0].strip
      return :failure, num_failures + ' Errors', strip_dir(error_info)
    end
 
    if summary_line =~ /([1-9]+)\d*\s+warning/
      num_failures = $1
      error_info = detail.grep(/\([0-9]+\)/)[0].strip
      return :warning, num_failures + ' Warnings', strip_dir(error_info)
    end
    
    return :success, 'All files are clean', ''
  end
  
  def strip_dir(text)

    # Move to function/class w/ win32 related code
    if (text[0, @dir.length] == @dir)
      text = text[(@dir.length + 1)..-1]
    end    
    
  end
  
end