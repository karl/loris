class ExtensionFilter
  
  def initialize(file_class, extension)
    @file_class = file_class
    @extension = extension.downcase
  end
  
  def filter(file_name)
    return file_type(file_name) == @extension
  end

  # Return the part of the file name string after the last '.'
  def file_type(file_name)
    @file_class.extname(file_name).gsub( /^\./, '' ).downcase 
  end
  
  def complete()
  end
  
end