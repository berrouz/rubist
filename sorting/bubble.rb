arr = [5,6,23,12,9,1,7,2,3]
arr.each_index {|i| arr[i-1] <  arr[i] }
puts arr