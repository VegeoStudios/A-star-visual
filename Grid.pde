public class Grid {
  
  public int w, h;
  
  public Node start, end;
  
  private Node[][] nodes;
  
  
  
  public Grid(int w, int h) {
    this.w = w;
    this.h = h;
    
    nodes = new Node[w][h];
    
    for (int i = 0; i < this.w; i++) {
      for (int j = 0; j < this.h; j++) {
        nodes[i][j] = new Node(i, j);
      }
    }
    
    start = nodes[floor(random(this.w))][floor(random(this.h))];
    end = start;
    
    while (start.obstacle) start = nodes[floor(random(this.w))][floor(random(this.h))];
    while (end == start || dist(end.x, end.y, start.x, start.y) < 20 || end.obstacle) {
      end = nodes[floor(random(this.w))][floor(random(this.h))];
    }
  }
  
  public void Show() {
    for (int i = 0; i < this.w; i++) {
      for (int j = 0; j < this.h; j++) {
        nodes[i][j].Show();
      }
    }
  }
  
  public Node GetNode(int x, int y) {
    return nodes[x][y];
  }
}
