class Person
  attr_accessor :gender, :age, :height, :indeks, :summa
	def initialize
		@gender = rand(2)
		@age 		= rand(101)
		@height = rand(201)
		@indeks = rand(1000000)
		@summa  = (rand(1000000)+rand(0)).round(1)
	end
end

class Array
	def where options={}
	  raise ArgumentError unless options.class == Hash
		options.each do |key, value|
  b
		end
	end

	def select_by(options)
		case options.values.first.class
		when Range then
      select { |person| options.values.first.include?(person.send(options.keys.first)) }
		when Fixnum then
      select { |person| options.values.first == person.send(options.keys.first) }
	  else 
		options.values.first.class.inspect
		end
	end
end

puts Array.new(100){ Person.new }.select_by({:age => 40..45})
