module Tryl
   puts self
  class << self
    def hello
      puts "Hello from class method"
    end
  end
  
  def hello
    puts "Hello from instance method"
  end
end


class Own
  include Tryl
end

Own.hello