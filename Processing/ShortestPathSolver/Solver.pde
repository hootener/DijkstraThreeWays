//Description: Solver class. Responsible for solving the shortest paths problem. 
class Solver{
  int m_NodeCount;
  ArrayList m_Graph;
  ArrayList m_PossibleNodes;
  
  //ctor
  Solver(int nodeCount){
    m_NodeCount = nodeCount;
    m_Graph = new ArrayList();
    m_PossibleNodes = new ArrayList();
  }
  
  //Adds a tuple to the graph
  void AddTuple(Tuple aTuple){
    m_Graph.add(aTuple);
  }
  
  //outputs the graph in text form
  void OutputGraph(){
    println("Nodes: " + m_NodeCount);
    println("Graph");
    for(int i = 0; i < m_Graph.size(); i++){
      ((Tuple)m_Graph.get(i)).outputTuple();
    }
  }
    
  //main body of solver. Takes a start node and returns the shortest path to 
  // all other possible nodes. Updates global shortestPath data structure
  void Solve(int startNode){
    if(startNode >= 0 && startNode < m_NodeCount){
      CloseNode(startNode);
      m_PossibleNodes = GetPossibleNodes(startNode, 0);
      Tuple startTuple = new Tuple(startNode,startNode,0);
      startTuple.m_PathDistanceFromStart = 0;
      shortestPath.add(startTuple);
      
      while((m_PossibleNodes.isEmpty() == false) && (shortestPath.size() < m_NodeCount)){
        Tuple closest = ClosestAvailableNode();
        if (closest != null){
          shortestPath.add(closest);
          CloseNode(closest.m_EndNode);
          startNode = closest.m_EndNode;
         ArrayList newNodes = GetPossibleNodes(startNode, closest.m_PathDistanceFromStart);
         if(newNodes != null) m_PossibleNodes.addAll(newNodes);
        }
        else break;
      }
      
    }
    else{
      println("Node " + startNode + "is invalid. Please restart the program and try again.");
    }
  }
  
  //Determine the closest node from a list of nodes
  Tuple ClosestAvailableNode(){
    Tuple shortest = null;
    int shortestDist = 32767;
    int removalIndex = 0;
    
    for(int i = 0; i < m_PossibleNodes.size(); i++){
      Tuple aTuple = (Tuple)m_PossibleNodes.get(i);
      if(aTuple.m_PathDistanceFromStart < shortestDist && aTuple.m_Open == true){
        shortest = aTuple;
        //shortest.m_Open = false;
        shortestDist = shortest.m_PathDistanceFromStart;
        removalIndex = i;
      }
    }
   if(shortest != null){ 
     shortest.m_Open = false; 
     m_PossibleNodes.remove(removalIndex);
   }
     return shortest;   
  }
  
  //return a  list of nodes that can be reached from node
  ArrayList GetPossibleNodes(int node, int distanceFromStart){
    ArrayList possibles = new ArrayList();
    for(int i = 0; i < m_Graph.size(); i++){
      Tuple tuple = (Tuple)m_Graph.get(i);
      if(tuple.m_StartNode == node && tuple.m_Open == true){
       tuple.m_PathDistanceFromStart =  distanceFromStart + tuple.m_PathLength;
        possibles.add(tuple);
      }
    }
    return possibles;
  }
  
  //close node marks a node as closed.
  void CloseNode(int node){
    for(int i = 0; i < m_Graph.size(); i++){
      Tuple aTuple = (Tuple)m_Graph.get(i);
      if(aTuple.m_EndNode == node) aTuple.m_Open = false;
    }
  }
   
}
