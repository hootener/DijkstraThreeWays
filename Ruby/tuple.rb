#description: Tuple class. Stores startNode, endNode, length and pathDistance. The
#class also overloads the == operator and provides a couple of convenience functions for
#creating and outputting Tuples.

class Tuple
  attr_accessor :startNode
  attr_accessor :endNode
  attr_accessor :length
  attr_accessor :pathDistance #the distance from the start node.

  #creates a tuple from an input string
  def initialize(tupleString)
    @pathDistance = 1.0/0 #Infinity
    if tupleString.kind_of?(Array)
      @startNode = tupleString.first.to_i
      @endNode = tupleString.at(1).to_i
      @length = tupleString.at(2).to_i
    elsif tupleString.nil?
      @startNode = 0
      @endNode = 0
      @length = 0
    end
  end

  #sets self = tuple. Attempted to overload the = operator here and ran into problems.
  def assign(tuple)
    if tuple.kind_of?(Tuple)
      @startNode = tuple.startNode
      @endNode = tuple.endNode
      @length = tuple.length
      @pathDistance = tuple.pathDistance
    else
      puts "assign failed to assign value to Tuple"
    end
  end

  #operator overloading in Ruby example seen here.
  def ==tuple
    if tuple.kind_of?(Tuple)
      if ((self.startNode == tuple.startNode) and (self.endNode == tuple.endNode) and (self.length == tuple.length))
        return true
      end
    end
    return false
  end

  #creates a tuple from three numbers
  def populate_from_numbers(startNode, endNode, length)
    string_array = Array.new
    string_array << startNode.to_s << endNode.to_s << length.to_s
    Tuple.new(string_array)
  end

  #returns a formatted string that represents the tuple
  def formatted_tuple
    "(#{@startNode}, #{@endNode}, #{@length})"
  end
end
