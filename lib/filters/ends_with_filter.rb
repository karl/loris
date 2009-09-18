require 'extensions/string.rb'

class EndsWithFilter
  
  def initialize(text)
    @text = text.downcase
  end
  
  def filter(file_name)
    return file_name.downcase.ends_with? @text
  end
  
  def complete()
  end
  
end