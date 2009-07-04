class JSpecTask
 
  def initialize(jspec)
    @jspec = jspec
  end
  
  def run(modified_files)
    detail = @jspec.execute

    summary = make_summary(detail)
    state = get_state(summary)

    return {
        :state => state,
        :title => 'JSpec',
        :summary => summary,
        :detail => detail
      }
  end
  
  def make_summary(detail)
    summary_line = detail.grep( /Passes:/ )[0]
    return '' if summary_line.nil?
    
    # remove console colour information and trim start and end white space
    return summary_line.gsub(/\e\[[0-9]+m?/, '').strip
  end
  
  def get_state(summary)
    if summary == ''
      return :error 
    elsif summary =~ /Failures:\s+[1-9]\d*/
      return :failure
    end
    return :success
  end
  
end