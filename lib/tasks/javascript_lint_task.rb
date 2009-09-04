class JavascriptLintTask
 
  def initialize(javascript_lint)
    @javascript_lint = javascript_lint
  end
  
  def run(files)
    all_files = files[:all]
    mofified_files = files[:filtered]
    
    return nil if (!@javascript_lint.is_configured? all_files) 

    detail = @javascript_lint.execute()
    
    state, summary, first = parse_result(detail)

    return {
        :state => state,
        :title => 'Javascript Lint',
        :summary => summary,
        :first => first,
        :detail => detail
      }
  end
  
  def parse_result(detail)
    summary_line = detail.grep( /\d+\s+error.*,\s+\d+\s+warning.*/ )[0]
    
    if summary_line.nil?
      # error
      error_info = (detail + "\nUnknown Error!").to_a[0]
      return :error, 'Error', error_info
    end
    
    if summary_line =~ /([1-9]+)\d*\s+error/
      num_failures = $1
      error_info = detail.grep(/\([0-9]+\):([^:]*)Error:/)[0]
      return :failure, num_failures + ' Errors', error_info
    end

    if summary_line =~ /([1-9]+)\d*\s+warning/
      num_failures = $1
      error_info = detail.grep(/\([0-9]+\)/)[0]
      return :warning, num_failures + ' Warnings', error_info
    end
    
    return :success, 'All files are clean', ''
    
  end
  
end