#project: Ruby shortest path solver
#description: Solver class. Responsible for creating a graph and solving it. public methods
#include solve, to solve the graph; output_formatted_graph, to output a graph once it
#has been loaded; and output_shortest_paths to output the shortest paths list after
#the graph has been solved.

class Solver
  attr_accessor :graph
  attr_reader :nodeCount
  attr_accessor :possibleNodes

  #consider initialize to the be the ''constructor''. Here, it takes in a filename,
  #opens the file, and creates the graph. All in about 12 lines of code.
  def initialize(filename)
    if File::exists?(filename.to_s)
      @file = File.open(filename.to_s)
      @nodeCount = @file.gets.to_i #assumes first line is the node count
      @graph = Array.new
      @shortestPath = Array.new
      @possibleNodes = Array.new
      #output node Numbers
      puts "Number of Nodes: #{@nodeCount}"
      @file.each_line("\n") do
        |line| @graph << Tuple.new(line.split(" ")) #create graph.
      end
    else
      "Could not find #{filename}"
    end
  end

  #main body of the solver. Takes a start node and determines the shortest path
  #to all other possible nodes.
  def solve(node)
    #remove any paths that point back to the start node
    if node >= 0 and node < @nodeCount
      remove_visited_nodes(node)
      @possibleNodes = available_tuples(node, 0)
      #create a zero length start node for the first entry into shortest path.
      start_tuple = Tuple.new(["#{node}","#{node}","#{0}"])
      start_tuple.pathDistance = 0
      @shortestPath << start_tuple

      while (!(@possibleNodes.empty? and @shortestPath != @nodeCount))
        #possibleNodes.each{|tuple| puts tuple.formatted_tuple}
        #select the shortest length
        #search the graph, remove the node chosen and any tuple with that node as
        #a destination, repeat until all nodes are solved, or
        @shortestPath << closest_available_node
        #@shortestPath.each{|tuple| puts tuple.formatted_tuple}
        remove_visited_nodes(@shortestPath.last.endNode)
        node = @shortestPath.last.endNode
        #puts "graph size: #{@graph.length}"
        available_tuples(node, @shortestPath.last.pathDistance).each {|tuple| @possibleNodes <<tuple}
      end
    else
      puts "node #{node} is invalid. Graph will not be solved."
    end
    
  end

  #outputs a formatted graph using the tuple style representation from Lisp project.
  #Note, this uses Ruby's (awesome) block style to iterate over the graph. The
  #curly braces indicate a function block that is passed as a message (think Smalltalk)
  #into the each method of the graph object. |tuple| acts as an iterator in this case.
  def output_formatted_graph
    if @graph.length > 0
      @graph.each{|tuple| puts tuple.formatted_tuple}
    else
      puts "Please load a graph before attempting to output a formatted graph."
    end
  end
  def output_shortest_paths
    if @shortestPath.length > 0
      puts "Shortest paths using start node #{@shortestPath.first.startNode}:"
      puts "Node \t Distance"
      @shortestPath.each{|tuple| puts "#{tuple.endNode} \t #{tuple.pathDistance}"}
    else
      puts "output_shortest_paths cannot complete because the graph has not been solved."
    end
  end

  #PRIVATE METHODS#
  private
    #returns an array of tuples that are reachable from node. Also updates their path
    #distance.
    def available_tuples(node, pathDistance)
      reachablenodes = Array.new
      @graph.each do |tuple|
        if tuple.startNode == node
          tuple.pathDistance = pathDistance + tuple.length
          reachablenodes << tuple
          #@graph.delete(tuple)
        end
      end
      reachablenodes
    end

    #returns the shortest length node from a set of possible nodes
    def closest_available_node
      shortest = 1.0/0 #initialize to infinity. A little strange, perhaps.
      shortesttuple = Tuple.new(nil)
     @possibleNodes.each do|tuple|
        if tuple.pathDistance < shortest
          shortest = tuple.pathDistance
          shortesttuple.assign(tuple)
        end
      end
      shortesttuple
    end

    #removes and tuple containing node as an endNode from the graph
    def remove_visited_nodes(node)
      @graph.delete_if {|tuple| tuple.endNode == node}
      @possibleNodes.delete_if{|tuple| tuple.endNode == node}
    end
end