# Max Rogers
# 107979405
# April 10, 2014
# Machine Learning Hw1
# K-Nearest Neighbor for Handwritting Recognization
# This program will load in a .dat file that contains a number of training points
# Then using Eucliean Distance calculations determine what classification the test.dat belongs to
require 'knnball'

def main
	k = 3 #k is the number of nearest neighbors to use

	puts "Enter the K you wish to use"
	k = gets.chomp.strip
	data = loadData
	#data.each { |d| puts "#{d}"}
	grids = loadTransGrids
	#printGrid(grids, 8)
	test_data = loadData true
	trial_data = loadTrialData
	puts "Building KnnBall"
	nodes = KnnBall.build(data)
	trial_data.each_with_index do |trial, index|
		puts "Trial: #{index}"
		neighbors = findKNN(nodes,trial,data,k)
		neighbors.each do |neighbor|
			printGrid(grids,neighbor[:id].to_i)
			puts ""
		end
		#break if index >= 1
	end
end

def findKNN(nodes,trial,data,k)
	results = nodes.nearest(trial[:point],limit: k.to_f)
	puts "Classification: #{findClassification(results)}"
	return results
end

def findClassification(results)
	classes = Array.new(10,0)
	results.each do |r|
		#puts "#{r[:key]}"
		classes[r[:key].to_i] += 1
	end
	return classes.index(classes.max)
end

def loadData(trial=false)
	
	data = []
	if trial 
		puts "Loading Test Trans"
		f = File.open("optdigits_test_trans.dat")
	else
		puts "Loading Training Trans"
		f = File.open("optdigits_train_trans.dat")
	end
	
	index = 0
	f.each_line do |input|
		input.rstrip! #This removes any leftover whitespace from the right of the read
		input =  input.split(" ").collect{|i| i.to_f} #returns an array created from substrings seperated by spaces and converts them into floats ex. [0.0,2.0,14.0,...,9.0]
		key = input.pop #This pops off the last element of the array input. This element will be used as the classifier
		hash = {id: index, key: key, point: input} #creates a hash that will be used later for the KDTree
		index += 1
		data.push hash
	end
	f.close
	return data
end

def loadTrialData
	
	data = []
	puts "Loading Trial Trans"
	f = File.open("optdigits_trial_trans.dat")
	
	index = 0
	f.each_line do |input|
		input.rstrip! #This removes any leftover whitespace from the right of the read
		input =  input.split(" ").collect{|i| i.to_f} #returns an array created from substrings seperated by spaces and converts them into floats ex. [0.0,2.0,14.0,...,9.0]
		hash = {id: index, point: input} #creates a hash that will be used later for the KDTree
		index += 1
		data.push hash
	end
	f.close
	return data
end

def loadTransGrids
	puts "Loading Training Grids"
	data = []
	f = File.open("optdigits_train.dat")
	f.each_line do |input|
		input.rstrip!
		input = input.split(" ")
		key = input.pop
		hash = {key: key, point: input}
		data.push hash
	end
	f.close
	return data
end

def printGrid(grids,id)
	count = 1
	grids[id][:point].each do |ele|
		print "#{ele}"
		puts "" if count % 32 == 0
		count +=  1
	end
end

main

puts "To Quit type \'Q\' or 'q'"
input = ""
input = gets.chomp until input.strip.capitalize.eql? "Q"