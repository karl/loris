class JasmineCIRunner

  def initialize(dir, js_filter)
    @dir = dir
    @js_filter = js_filter
  end

  def name
    return 'Jasmine CI'
  end

  def execute
    return `rake jasmine:ci 2>&1`
  end

  def is_configured?(all_files)
    return all_files.include?(@dir + '/spec/javascripts/support/jasmine.yml')
  end

  def should_run?(modified_files)
    return !(modified_files.detect { |file| @js_filter.filter(file) }).nil?
  end

end