class GoogleLintParser
 
  def initialize(dir)
    @dir = dir
 
    # TODO: Tidy!
    if (RUBY_PLATFORM =~ /mswin32/)
      @dir = @dir.gsub('/', '\\')
    end 
  end
  
  def parse_result(detail)
    summary_line = detail.grep( /Found \d+\s+error*/ )[0]

    if not detail.grep( /no errors found./ )[0].nil?
      return :success, 'All files are clean', ''
    end
    
    if summary_line =~ /([1-9]+)\d*\s+error/
      num_failures = $1
      error_info = detail.grep(/FILE/)[0].strip
      file_name = /:(.+) -----/.match error_info.strip
      return :failure, num_failures + ' Errors', strip_dir(file_name)
    end
    
    # error
    error_info = (detail + "\nUnknown Error!").to_a[0].strip
    return :error, 'Error', error_info
  end
  
  def strip_dir(text)

    # Move to function/class w/ win32 related code
    if (text[0, @dir.length] == @dir)
      text = text[(@dir.length + 1)..-1]
    end    
    
    text
  end
  
end