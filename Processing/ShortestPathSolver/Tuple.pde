//Description: Tuple class. Serves as data structure for tuples in the form (startNode, endNode, distanceBetween). 
// Also responsible for drawing individiual nodes. 

class Tuple{
  int m_StartNode;
  int m_EndNode;
  int m_PathLength;
  int m_PathDistanceFromStart;
  int m_xPos;
  int m_yPos;
  color m_Color = color(0,0,200);
  boolean m_Open;
  boolean m_Drawn;
  
  Tuple(int start, int end, int len){
    m_StartNode = start;
    m_EndNode = end;
    m_PathLength = len;
    m_Open = true;
    m_Drawn = false;
    m_xPos = int(random(25,475));
    m_yPos = int(random(25,475));
  }
  
  void outputTuple(){
    println("(" + m_StartNode + ", " + m_EndNode + ", " + m_PathLength + ")");
  }
  
  void drawTuple(){
    fill(m_Color);
    ellipseMode(CENTER);
    ellipse(m_xPos, m_yPos, 20, 20);
    fill(255);
    text(nf(m_EndNode,0,0), m_xPos - 3,m_yPos + 4);
  }
}
