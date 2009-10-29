class JsTestDriverParser
  
  def parse_result(detail)
    summary_line = detail.grep( /Total \d+ tests/ )[0]
    
    if summary_line.nil?
      # error
      error_info = (detail + "\nUnknown Error!").to_a[0].strip
      return :error, 'Error', error_info
    end

    lost_a_browser = !detail.grep(/The browser \d+ is not available anymore/)[0].nil?
    if summary_line =~ /Total 0 tests/ && lost_a_browser
      return :error, 'No Tests Run', 'You may not have a browser connected to JS Test Driver'
    end    
    
    if summary_line =~ /Errors: ([1-9]+)/
      num_errors = $1
      error_info = detail.grep(/error \([0-9]+.[0-9]+ ms\)/)[0].strip
      return :failure, num_errors + ' Errors', error_info
    end

    if summary_line =~ /Fails: ([1-9]+)/
      num_failures = $1
      error_info = detail.grep(/failed \([0-9]+.[0-9]+ ms\)/)[0].strip
      return :failure, num_failures + ' Failures', error_info
    end

    return :success, 'All tests pass', ''
    
  end
  
end