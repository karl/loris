class JsTestDriverTask
 
  def initialize(js_test_driver)
    @js_test_driver = js_test_driver
  end
  
  def run(files)
    all_files = files[:all]
    mofified_files = files[:filtered]
    
    return nil if (!@js_test_driver.is_configured? all_files) 

    detail = @js_test_driver.execute()
    
    state, summary, first = parse_result(detail)

    return {
        :state => state,
        :title => 'JS Test Driver',
        :summary => summary,
        :first => first,
        :detail => detail
      }
  end
  
  # Move to parse class
  def parse_result(detail)
    summary_line = detail.grep( /Total \d+ tests/ )[0]
    
    if summary_line.nil?
      # error
      error_info = (detail + "\nUnknown Error!").to_a[0].strip
      return :error, 'Error', error_info
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