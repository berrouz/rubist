require 'benchmark'
class 	Array
	def	each_two
		return to_enum :each_two unless block_given?
		self.map.each_with_index do |n,i|
			yield([self[i], self[i+1]]) if i < self.size-1
		end.compact
	end
	
	def missed	
	  each_two.select {|a,b| a != b-1 }.map {|range| (range.first+1)...range.last}.map(&:to_a).reduce(:+)
	end
end
test_array = [*1..100000]
test_array.delete_at(567)
test_array.delete_at(45782)
puts test_array.missed

Benchmark.bm(2) do |x|
  x.report("time") { 10.times {test_array.missed }}
end
