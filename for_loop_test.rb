array1 = [1,2,3]
array2 = [3,2,1]

for i in 0..array1.size-1
	puts "#{array1[i]}"
end

hash1 = {a: 20, b: 30, c:10}
hash1 = hash1.sort_by {|k,v| v}
puts hash1.inspect
hash1 = hash1.sort_by {|k,v| v}.reverse
puts hash1.inspect