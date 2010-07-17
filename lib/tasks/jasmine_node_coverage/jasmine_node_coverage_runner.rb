require 'FileUtils'

class JasmineNodeCoverageRunner
  
  def initialize(jasmine_runner, coverage, config)
    @jasmine_runner = jasmine_runner
    @coverage = coverage
    @config = config
  end
  
  def name
    return 'Coverage'
  end
  
  def execute
    @config.reload

    source_dir = @config.source_dir
    coverage_dir = source_dir + "-cov"

    FileUtils.rm_rf coverage_dir
    
    output = @coverage.run source_dir, coverage_dir
    @jasmine_runner.source_dir coverage_dir
    return output + "\n\n" + @jasmine_runner.execute
  end
  
  def is_configured?(all_files)
    return @jasmine_runner.is_configured? all_files
  end
  
  def should_run?(modified_files)
    return @jasmine_runner.should_run? modified_files
  end
  
end