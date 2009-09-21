class CommandLineTask
 
  def initialize(runner, parser)
    @runner = runner
    @parser = parser
  end
  
  def run(files)
    all_files = files[:all]
    modified_files = files[:filtered]
    
    return nil if (!@runner.is_configured? all_files)
    return nil if (!@runner.should_run? modified_files)
 
    detail = @runner.execute
    
    state, summary, first = @parser.parse_result(detail)
 
    return {
        :state => state,
        :title => @runner.name,
        :summary => summary,
        :first => first,
        :detail => detail
      }
  end
    
end