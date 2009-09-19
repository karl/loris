class JSpecParser
 
  def parse_result(detail)
    summary_line = detail.grep( /Passes:/ )[0]
    
    if summary_line.nil?
      # error
      error_info = (detail + "\nUnknown Error!").to_a[0]
      return :error, 'Error', error_info
    end
    
    # remove console colour information and trim start and end white space
    summary_line = remove_colour(summary_line).strip
    
    if summary_line =~ /Failures:\s+([1-9]+)\d*/
      num_failures = $1
      error_line = detail.grep(/\[31m/)[1] || ''
      error_info = remove_colour(error_line).strip
      return :failure, num_failures + ' Failures', error_info
    end

    
    return :success, 'All Passed', summary_line
  end
  
  def remove_colour(string)
    return string.gsub(/\e\[[0-9]+m?/, '')
  end
  
end