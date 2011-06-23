class JasmineCIParser

  def parse_result(detail)
    summary_line = detail.grep( /\d+ examples?, \d+ failures?/ )[0]

    if summary_line.nil?
      # error
      error_info = (detail + "\nUnknown Error!").to_a[0].strip
      return :error, 'Error', error_info
    end

    if summary_line =~ /([1-9]+) failures?/
      num_errors = $1

      error_info = 'Unknown error'
      if detail =~ /1\) (.*?)[\n]{2}/m
        error_info = $1
      end
      return :failure, num_errors + ' Errors', error_info
    end

    return :success, 'All specs pass', ''

  end

end