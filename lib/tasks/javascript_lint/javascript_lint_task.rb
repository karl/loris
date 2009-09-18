class JavascriptLintTask
 
  def initialize(javascript_lint, dir)
    @javascript_lint = javascript_lint
    @dir = dir
 
    # TODO: Tidy!
    if (RUBY_PLATFORM =~ /mswin32/)
      @dir = @dir.gsub('/', '\\')
    end
 
  end
  
  def run(files)
    all_files = files[:all]
    modified_files = files[:filtered]
    
    return nil if (!@javascript_lint.is_configured? all_files)
    return nil if (!@javascript_lint.should_run? modified_files)
 
    detail = @javascript_lint.execute()
    
    state, summary, first = parse_result(detail)
 
    # TODO: Tidy!
    # Move to function/class w/ win32 related code
    if (first[0, @dir.length] == @dir)
      first = first[(@dir.length + 1)..-1]
    end
 
    return {
        :state => state,
        :title => 'Javascript Lint',
        :summary => summary,
        :first => first,
        :detail => detail
      }
  end
  
  # Move to parse class
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
      return :failure, num_failures + ' Errors', error_info
    end
 
    if summary_line =~ /([1-9]+)\d*\s+warning/
      num_failures = $1
      error_info = detail.grep(/\([0-9]+\)/)[0].strip
      return :warning, num_failures + ' Warnings', error_info
    end
    
    return :success, 'All files are clean', ''
    
  end
  
end