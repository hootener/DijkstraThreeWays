INSTALLATION:

Processing can be obtained from: http://processing.org/download/

It is assumed that you have Java installed on your machine. Java is necessary to compile Processing sketches (i.e., ''programs''), as Processing is built from Java. 

Installation is a simple, click through, process. 

USAGE:

Once processing is installed, open the ShortestPathSolver sketch in the included ShortestPathSolver folder. Two other sketches exist in this folder: Tuple and Solver. These sketches contained classes that are used in ShortestPathSolver. Opening the ShortestPathSolver sketch should open all three of the sketches as tabs in a single Processing window.

Processing is very bad at accepting user input from the keyboard, and cannot even do it without tremendous headache on the part of the programmer. External libraries exist to make this process easier, but I did not want to rely on external libraries for this project. Therefore, the input file is specified in line 21 of the ShortestPathSolver sketch and the start node for the solver is specified in line 24 of that same sketch. 

This project comes with a few sample graphs to try. During testing, it crashed on biggraph4.txt, but processed biggraph3.txt in approximately 300 msecs. Feel free to run the solver with any of these graphs by changing the file name in line 21 of the ShortestPathSolver sketch. 

When you are ready to run the program, hit the play button located in the upper left corner of the application window, or press Ctrl + R. 

The solution to graph will appear in the output window at the bottom of the Processing application. Sample output is as follows:

Nodes: 5
Graph
(0, 1, 10)
(0, 3, 5)
(1, 2, 1)
(1, 3, 3)
(2, 4, 6)
(3, 1, 2)
(3, 2, 9)
(3, 4, 2)
(4, 0, 7)
(4, 2, 4)
Solving...
Node 	 Distance
1	0
2	1
3	3
4	5
0	12
Solver took: 0 msec to solve the graph.


GRAPHICAL REPRESENTATION:
As an added bonus, a visual representation of the shortest path is also shown. Nodes are represented with the proper connections and the distance to each node from the start node is shown underneath each node. Note that this representation is by no means a finished product. Node placement is random and things can overlap. So, if it looks bad, run the program again and the graph will reappear in a new orientation. Also note that the shortest path looks like total chaos for larger graphs. 