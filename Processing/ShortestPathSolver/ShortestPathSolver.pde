//Description: Main entry point for shortest path solver. Outputs textual and graphical versions of shortest path.
//Also responsible for reading in file. To change the file that is read in or the starting node, edit the indicated parameters
//in the setup() function below (lines 21 and 24).

String[] file;
int nodes = 0;
int w = 10;
int h = 10;
int startNode;
Solver graph;
ArrayList shortestPath;
boolean clicked;


void setup(){
  
  //!!!SPECIFY GRAPH FILE NAME HERE!!!
  file = loadStrings("graph.txt");
  
  //!!SPECIFY START NODE HERE!!!
  startNode = 1;
  
  size(500,500); 
  smooth();
  
  //initialize global data structures
  graph = new Solver(int(file[0]));
  shortestPath = new ArrayList();
  clicked = false;
  
  for(int i = 1; i<file.length; i++){
    String[] tuple = split(file[i], ' ');
    graph.AddTuple(new Tuple(int(tuple[0]),int(tuple[1]),int(tuple[2])));
  }
  graph.OutputGraph();
  long start, end, total;
  start = System.currentTimeMillis();
  println("Solving...");
  graph.Solve(startNode);
  end = System.currentTimeMillis();
  total = end - start;
  OutputShortestPath();
  println("Solver took: " + total + " msec to solve the graph."); 
}

//output graphical representation of shortest path. Node numbers are shown for each node and the path distance from each node to the start node is shown
//underneath each node. NOTE: positioning of the nodes is random. So if overlap occurs, you can run the program again to 
//get a different layout of the graph in graphical form. Textual representation will always be correct (hopefully ;) ). 
void draw(){
 background(255);
 fill(230);
 for(int i = 0; i< shortestPath.size(); i++){
   Tuple aTuple = (Tuple)shortestPath.get(i);
   if(i==0) aTuple.m_Color = color(200,0,0);
   int x1, y1, x2, y2;
   x1 = aTuple.m_xPos;
   y1 = aTuple.m_yPos;
   x2 = aTuple.m_xPos;
   y2 = aTuple.m_yPos;
   //draw a line from this start tuple to the end tuple.
   //get start node coordinates
   for(int j=0; j<shortestPath.size(); j++){
     Tuple bTuple = (Tuple)shortestPath.get(j);
     if(aTuple.m_EndNode == bTuple.m_StartNode){
       x2 = bTuple.m_xPos;
       y2 = bTuple.m_yPos;
     }
     //fill(0);
     //text(nf(bTuple.m_PathLength,0,0),((x1+x2)/2),((y1 + y2)/2));
     stroke(0,0,200);
     line(x1,y1,x2,y2); 
   }
   aTuple.drawTuple();
   fill(0);
   text(nf(aTuple.m_PathDistanceFromStart,0,0), x1, y1 + 22);
   //draw the path length
 
   
 } 
}

//output textual representation of shortest path.
void OutputShortestPath(){
  println("Node \t Distance");
  for(int i = 0; i< shortestPath.size(); i++){
    Tuple aTuple = (Tuple)shortestPath.get(i);
    println(aTuple.m_EndNode + "\t" + aTuple.m_PathDistanceFromStart);
  }
}





