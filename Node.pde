public class Node {
  
  private int x, y;
  private float screenX, screenY, centerScreenX, centerScreenY;
  
  private boolean obstacle;
  
  private Node previous = null;
  
  private float f, g, h;
  
  private int iterationSet;
  
  private boolean closed;
  
  
  public Node(int x, int y) {
    this.x = x;
    this.y = y;
    
    closed = false;
    
    obstacle = noise(map(x, 0, width, 0, width / 10), map(y, 0, height, 0, height / 10)) < 0.4;
    
    
    centerScreenX = map(this.x + 0.5, 0, gridwidth, 0, width);
    centerScreenY = map(this.y + 0.5, 0, gridheight, 0, height);
    
    screenX = map(this.x, 0, gridwidth, 0, width);
    screenY = map(this.y, 0, gridheight, 0, height);
  }
  
  public void Show() {
    fill(255);
    if (closed) fill(map(iterationSet, 0, iteration, 255, 255), map(iterationSet, 0, iteration, 255, 100), map(iterationSet, 0, iteration, 255, 100));
    if (openSet.contains(this)) fill(map(h, GetHighestH().h, GetLowestH().h, 200, 75), 255, map(h, GetHighestH().h, GetLowestH().h, 200, 75));
    if (grid.start == this) fill(0, 200, 255);
    if (grid.end == this) fill(0, 200, 255);
    if (!diagonals && obstacle) fill(0);
    rect(screenX, screenY, width/gridwidth + 1, height/gridheight + 1);
    
    
    
    fill(0);
    if (obstacle && diagonals) ellipse(centerScreenX, centerScreenY, width/gridwidth/2, height/gridheight/2);
    
    //if (path.contains(this)) {
    //  //fill(0, 255, 255);
      
    //  if (previous != null) {
    //    stroke(200, 0, 255);
    //    strokeWeight(5);
        
    //    if (finished) {
    //      stroke(0, 200, 255);
    //      strokeWeight(10);
    //    }
    //    if (nosolution) {
    //      stroke(255, 0, 100);
    //      strokeWeight(7);
    //    }
        
    //    line(centerScreenX, centerScreenY, previous.centerScreenX, previous.centerScreenY);
    //    noStroke();
    //  }
      
    //}
  }
  
  public void SetObstacle(boolean obstacle) {
    this.obstacle = obstacle;
  }
  
  public ArrayList<Node> GetNeighbors() {
    ArrayList<Node> neighbors = new ArrayList<Node>();
    
    if (x > 0) neighbors.add(grid.GetNode(x - 1, y));
    if (y > 0) neighbors.add(grid.GetNode(x, y - 1));
    if (x < gridwidth - 1) neighbors.add(grid.GetNode(x + 1, y));
    if (y < gridheight - 1) neighbors.add(grid.GetNode(x, y + 1));
    
    if (diagonals) {
      if (x > 0 && y > 0) neighbors.add(grid.GetNode(x - 1, y - 1));
      if (x < gridwidth - 1 && y < gridheight - 1) neighbors.add(grid.GetNode(x + 1, y + 1));
      if (x < gridwidth - 1 && y > 0) neighbors.add(grid.GetNode(x + 1, y - 1));
      if (x > 0 && y < gridheight - 1) neighbors.add(grid.GetNode(x - 1, y + 1));
    }
    
    
    return neighbors;
  }
  
  public void SetIteration(int iterationSet) {
    this.iterationSet = iterationSet;
  }
}
