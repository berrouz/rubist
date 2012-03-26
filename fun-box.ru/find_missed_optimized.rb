require 'rspec'
require 'benchmark'
class Array
  def	find_two_missed
    raise ArgumentError, "array should miss 2 elements" if last < size+2
    temp = self
    temp = temp.shorten
    while temp.size < 2
      temp = temp.first.shorten
			puts temp.first.size
      break if temp.first.adjacent? && temp.size == 1
    end
    return temp.first.return_which_are_missed if temp.size ==1
    temp.map(&:find_missed)
  end

  def mid_position
    @size%2 == 0 ? (size/2-1) : ((size+1)/2)-1
  end

  def shorten
    case get_shift
    when 0 then [self[mid_position,size-mid_position]]
    when 1 then [self[0, mid_position+1], self[mid_position,size-mid_position+1]]
    when 2 then [self[0, mid_position+1]]
    end
  end

  def get_shift
    case self[mid_position]
    when mid_position+first   then 0
    when mid_position+1+first then 1
    when mid_position+2+first then 2
    end
  end

  def return_which_are_missed
    (first+1..last-1).to_a
  end

  def adjacent?
    (last-first) == 3
  end

  def find_missed
    temp = self
    while temp.size > 2
      temp = temp.slice_array
    end
    temp.return_which_is_missed
  end

  def	slice_array
    case self[mid_position]
    when first+mid_position
      self[mid_position,size-mid_position+1]
    when first+mid_position+1
      self[0,mid_position+1]
    end
  end
end
arr = [*1..1000000]
arr.delete_at(2)
arr.delete_at(2)
arr1 = [*1..10000000]
arr1.delete_at(56)
arr1.delete_at(1090892)
Benchmark.bm(2) do |r|
  r.report("1000000 elements") {arr.find_two_missed}
  r.report("100000000 elements") {puts arr1.find_two_missed}

end
describe Array do

  it "should find middle positions" do
    [1,2,3,4,6,7,8,10,11,12].mid_position.should == 4
  end

  it "should find where 2 digits" do
    [1,2,3,4,5,6,7,8,10,11,12].get_shift.should == 0
    [1,2,3,4,6,7,8,10,11,12].get_shift.should == 1
    [1,2,4,6,7,8,9,10,11,12].get_shift.should == 2
  end

  it "should return 2 arrays " do
    [1,2,3,4,6,7,8,10,11,12].shorten.should == [[1,2,3,4,6], [6,7,8,10,11,12]]
    [1,2,4,6,7,8,9,10,11,12].shorten.should == [[1,2,4,6,7]]
    [1,2,4,6,7].shorten.should == [[1,2,4],[4,6,7]]
    [1,2,3,5,6,7,9,10].shorten.should == [[1,2,3,5],[5,6,7,9,10]]
    [1,2,3,4,5,6,7,9].shorten.should == [[4,5,6,7,9]]
    [1,2,3,4,5,6,8,10].shorten.should == [[4,5,6,8,10]]
  end

  it "should return missed from array" do
    [1,3].return_which_are_missed.should == [2]
  end

  it "should find 2 neighbor digits around missed in array" do
    [1,2,4,5,6].slice_array.should == [1,2,4]
    [1,2,4].slice_array.should == [2,4]
  end

  it "should return missed digit" do
    [1,2,4,5,6].find_missed.should == [3]
    [1,2,3,4,5,6,7,8,9,10,11,12,13,15].find_missed.should == [14]
  end

  it "should find 2 missed digits" do
    [1,2,4,6,7,8,9,10,11,12].find_two_missed.should == [[3],[5]]
  end
end
