
COMPILER INSTALLATION:
There are several methods to do this. The most straightforward I found was to install the NetBeans IDE. It installed Ruby for me and provides a nice IDE with which to read/write Ruby code. The download is about 80MB, the install is around 300MB. It's also cross platform. I have tested this code using the NetBeans IDE in both OSX and Windows and it runs and generates identical output for each OS. 

So, my recommendation is to  download the NetBeans IDE from: http://netbeans.org/downloads/index.html 
Select the "Download" button in the Ruby column on this page.

USAGE:
Using NetBeans is similar to using Visual Studio or any other IDE, really. Launch it after install, click on File > Open Project… and select the ShortestPathSolver project from wherever it resides on your hard drive. 

Once open, if you expand the Source Files branch in the Projects tree view on the left of the screen, you should see 4 .txt files containing different test graphs and three .rb files. The .rb files are the Ruby source files used to create this project. Similar to C++, main.rb is the entry point for the program, and solver.rb and tuple.rb are source files containing code for the Solver and Tuple class, respectively.

To run the program, hit F6 or click the green arrow from the toolbar across the top of the screen. The program will execute in a panel at the bottom of the IDE. The program will ask for a file name. If you decide to use a file included with the project, simply type its file name (e.g., graph.txt) as file paths are relatively referenced from the lib folder of the project where the .txt files (and other source files) reside.

Enter an appropriate start node and the solver will execute, outputting the graph, the shortest path list, and timing information. This solver has been confirmed to generate correct output with graph.txt, isolatedNode.txt, unreachableNode.txt, and will at least process the biggraph3.txt and biggraph4.txt files. Processing time was fairly slow for the bigger files. 17 seconds for biggraph3.txt and approximately 4 minutes for biggraph4.txt.

SAMPLE PROGRAM OUTPUT:
Enter a file name (i.e., fileName.txt):
graph.txt
Number of Nodes: 5
The graph (start node, end node, length):
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
Specify a start node:
3
Shortest paths using start node 3:
Node          Distance
3          0
1          2
4          2
2          3
0          9
Running time of solver (sec): 0.000272035598754883



ALTERNATIVE COMPILER OPTIONS:
If you don't want to go the NetBeans route, you can just install Ruby from: http://www.ruby-lang.org/en/downloads/ 
and use IRB (Ruby's interactive interpreter) at the command line to run the ShortestPathSolver project. Working from the IRB is similar to using CLISP or something of that sort, but if you want to go this route, you're on your own since usage and installation can vary slightly between different operating systems.