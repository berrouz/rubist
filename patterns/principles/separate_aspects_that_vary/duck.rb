
class		Duck
  %w(NotImplementedMethod).each{ |exc| const_set(exc, Class.new(StandardError)) }
  def quack
    rise
  end

  def swim
    rise
  end

  def display
    rise
  end

  def rise
    raise NotImplementedMethod
  end
end


class 
