class CoffeeScriptRunner

  def initialize(binary, dir, filter, dir_finder)
    @binary = binary
    @dir = dir
    @filter = filter
    @coffeescript_dir_finder = dir_finder

    @js_dir = dir + '/src'
  end

  def name
    return 'CoffeeScript'
  end

  def execute
    output = []

    @coffee_dirs.each do |coffee_dir|
      js_dir = coffee_dir.sub '/coffee-', '/'
      output.push `#{@binary} --output "#{js_dir}" --compile "#{coffee_dir}"  2>&1`
    end

    return output.join "\n"
  end

  # TODO: Only return true if we can find the node binary
  def is_configured?(all_files)
    @coffee_dirs = (@coffeescript_dir_finder.find all_files).uniq
    return @coffee_dirs.length > 0
  end

  def should_run?(modified_files)
    return !(modified_files.detect { |file| @filter.filter(file) }).nil? || modified_files.include?(@config)
  end

end