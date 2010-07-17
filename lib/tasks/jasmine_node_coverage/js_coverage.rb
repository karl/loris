class JsCoverage
  
  def initialize(jscoverage)
    @jscoverage = jscoverage
  end
  
  def run(source_dir, coverage_dir)
    return `"#{@jscoverage}" "#{source_dir}" "#{coverage_dir}"  2>&1`
  end
  
end