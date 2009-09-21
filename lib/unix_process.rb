class UnixProcess

  def create(command)
    exec(command) if fork.nil?
  end
  
end