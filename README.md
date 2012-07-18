DijkstraThreeWays
=================

Dijkstra's Shortest Path Algorithm implemented in Ruby, Lisp, and Processing. Handy for folks just starting out with any of those languages, I assume. The repository is broken into three separate folders Ruby, Lisp, and Processing. Instructions for how
to run each program are included below.

Lisp
----
Contains several test cases for consideration. As well as sample output (graph-output-start-1).
This implementation removes previously visited nodes from the search space to provide
a performance gain. Input files are formatted with the first number representing the size of the graph.
The following triples represent econnections and the edge weight of the connection.

dijkstra is the main entry point to the application. Type (dijkstra) at the Lisp command 
prompt to run the program.

Ruby
----
A readme contained in the Ruby folder describes one approach to using Ruby for the absolute beginner.
It assumes you do not have Ruby installed on your machine. Suffice to say, running the main.rb file will
execute the application. If you need more thorough instruction, consult the included readme.

Processing
----------

Open the ShortestPathSolver sketch in the included ShortestPathSolver folder. Two other sketches exist in this folder: Tuple and Solver. These sketches contain classes that are used in ShortestPathSolver. Opening the ShortestPathSolver sketch should open all three of the sketches as tabs in a single Processing window.

Several input files are included as test cases. The input file is specified in line 21 of the ShortestPathSolver sketch and the start node for the solver is specified in line 24 of that same sketch. Modify the code in these places to run different test
cases. 

This project comes with a few sample graphs to try. During testing, it crashed on biggraph4.txt, but processed biggraph3.txt in approximately 300 msecs. Feel free to run the solver with any of these graphs by changing the file name in line 21 of the ShortestPathSolver sketch. 

The solution to graph will appear in the output window at the bottom of the Processing application.
