#description: Solves the shortest path problem in Ruby. Outputs the graph and each node with
#the shortest path from a specified start node. This doesn't do much error checking at all. I
#assumed sane input files and have provided several .txt graph files in this code with which to
#test the program.
#A note on Ruby conventions...the following are forced by the language or are
#community standards. I tried to follow them at all times:
#    * ClassNames
#    * method_names
#    * methods_asking_a_question?
#    * slightly_dangerous_methods!
#    * @instance_variables
#    * $global_variables
#    * SOME_CONSTANTS or OtherConstants

#system requires
require 'benchmark'

#application requires
require "tuple.rb"
require "solver.rb"

### Main ###
puts "Enter a file name (i.e., fileName.txt):"
filename = gets.strip
while !File::exists?(filename)
  puts "Invalid file name, please try again:"
  filename = gets.strip
end

solver = Solver.new(filename)
if solver.graph.length != 0
  puts "The graph (start node, end node, length):"
  solver.output_formatted_graph
end

puts "Specify a start node:"
start = gets.to_i
while start < 0 || start > solver.nodeCount
  puts "Invalid start node, try again:"
  start = gets
end

running_time = "#{Benchmark.realtime {solver.solve(start)}}"
solver.output_shortest_paths
puts "Running time of solver (sec): " + running_time


