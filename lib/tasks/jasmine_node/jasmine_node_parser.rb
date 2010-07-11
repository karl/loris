class JasmineNodeParser
 
  def initialize(dir)
    @dir = dir
  end
  
  def parse_result(detail)
    summary_line = detail.grep( /\d+\s+tests?.*,\s+\d+\s+assertions?.*,\s+\d+\s+failures?.*/ )[0]

    if summary_line.nil?
      # error
      error_info = detail.grep(/Error: /)  || ["Unknown Error!"]
      return :error, 'Error', error_info[0].strip
    end
    
    if summary_line =~ /([1-9]+)\d*\s+failures?/
      num_failures = $1
      error_info = detail.grep(/Error: /)[0].strip
      return :failure, num_failures + ' Errors', error_info
    end
 
    return :success, 'All tests passed', ''
  end
  
end