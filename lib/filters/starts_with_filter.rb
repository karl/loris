require 'rubygems'
require 'extensions/string'

class StartsWithFilter
  
  def initialize(text)
    @text = text.downcase
  end
  
  def filter(file_name)
    return file_name.downcase.starts_with?(@text)
  end
  
  def complete
  end
  
end