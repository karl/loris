class RSpecTask
 
  def initialize(rspec)
    @rspec = rspec
  end
  
  def run(files)
    all_files = files[:all]
    mofified_files = files[:filtered]
    
    return nil if (!@rspec.is_configured? all_files) 

    detail = @rspec.execute()
    
    state, summary, first = parse_result(detail)

    return {
        :state => state,
        :title => 'RSpec',
        :summary => summary,
        :first => first,
        :detail => detail
      }
  end
  
  # Move to parse class
  def parse_result(detail)
    summary_line = detail.grep( /\d+ examples?, \d+ failures?/ )[0]
    
    if summary_line.nil?
      # error
      error_info = (detail + "\nUnknown Error!").to_a[0].strip
      return :error, 'Error', error_info
    end
    
    if summary_line =~ /([1-9]+) failures?/
      num_errors = $1
      error_info = detail.grep(/FAILED/)[0].strip
      return :failure, num_errors + ' Errors', error_info
    end

    return :success, 'All specs pass', ''
    
  end
  
end