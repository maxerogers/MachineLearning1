# Max Rogers
# 107979405
# April 10, 2014
# Machine Learning Hw1
# K-Nearest Neighbor for Handwritting Recognization
# This program will load in a .dat file that contains a number of training points
# Then using Eucliean Distance calculations determine what classification the test.dat belongs to
def main
	m = 10 #m is the number of Testcases to import
	k = 3 #k is the number of nearest neighbors to use
	t = true #t deterimes if we are to use the Test or Training data

	puts "Enter the number of m testcases:"
	puts "Enter the K you wish to use"
	puts "Enter whether you wish to use the training or test data set"

	data = loadData(m,t)
	trials = loadTrialData()
	puts "Number of Trials: #{trials.size}"
	trials.each do |trial| 
		findKNN(k,data,trial)
	end
end

def loadData(m,t)
	if t
		filename = "optdigits_train_trans.dat"
	else
		filename = "optdigits_test_trans.dat"
	end
	data = {} #this is a hashmap that will hold the classification as a key and the other 64 elements as its value	
	f = File.open(filename)
	count = 0
	puts "Loading in data from #{filename}"
	f.each_line do |input|
		#break if count >= m #this will make sure we only load m number of test cases
		input.rstrip! #This removes any leftover whitespace from the right of the read
		input =  input.split(" ").collect{|i| i.to_i} #returns an array created from substrings seperated by spaces and converts them into integers
		data[input.pop]= input #adds the array to the large data hash. Using the classifier as the key
		count+=1
	end
	
	f.close #closing file stream
	puts "Finished Loading Data: #{count} entries"
	#internal test purposes
	#data.each { |k,v| puts "#{k}:#{v}" }

	return data #the keyword return isn't necessary in Ruby since it is done by default but since I am unsure if the grader is familiar with Ruby i will be using this explicit notation
end

def loadTrialData
	puts "Loading in Trial Data"
	test_data = []
	f = File.open("optdigits_trial_trans.dat")
	f.each_line do |input|
		input.rstrip!
		test_data.push( input.split(" ").collect{|i| i.to_i} )
	end
	#puts "Finished in Test Data:\n#{test_data}"
	#puts "Elements.size: #{test_data.size}"
	return test_data
end

def findKNN(k,data,trialdata)
	puts "Now Calculating #{k}-Nearest Neighbors:"

	results = findNN(data,trialdata)
	count = 0
	results = results.sort_by{ |_key,value| value} #this will sort the resulting NNHash by the lowest value(which should be the closest Neighbor)
	neighbors = []
	results.each do |key,value|
		break if count >= k
		puts "#{key}:#{value}"
		neighbors.push key
		count += 1
	end
	puts "Classification: #{classify(neighbors)}"
	return results
end

# Calculates the closeness of all of the Data Vectors to our Trial Vector
def findNN(data,trialdata)
	results = {}
	data.each do |key, data_i|
		results[key] = euclieanDistance(data_i,trialdata)
	end
	return results
end

#calculating the eucliean distance between Vector Xi from Vector Xj
def euclieanDistance(data_vector,trial_vector)
	sum = 0.0 #ensuring it is a float
	for k in 0..data_vector.size-1
		sum += (data_vector[k] - trial_vector[k])**2 #calculating the absolute distance from value X_i[k] from X_j[k]
	end
	sum = Math.sqrt(sum) #square rooting it
	return sum
end

def classify(neighbors)
	classification = Array.new(10,0) #builds an array of 0 to 9 with initial value of 0
	neighbors.each do |key|
		classification[key.to_i] += 1 #increments when a certain key is found
	end
	return classification.index(classification.max) #return the index(key) that occurs the most
end
main

puts "To Quit type \'Q\' or 'q'"
input = ""
input = gets.chomp until input.capitalize.eql? "Q"