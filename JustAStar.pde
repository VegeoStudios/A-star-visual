Grid grid;

int restartdelay = 20;
int wait = 0;

int gridwidth = 130;
int gridheight = 130;

int debugTextSize = 24;

int stepsPerFrame = 50;

boolean diagonals = true;
boolean loop = true;

boolean finished;
boolean nosolution;

int iteration;

int runs = 60;
boolean animate = false;

ArrayList<Node> openSet;
ArrayList<Node> path;
ArrayList<ArrayList<Node>> paths;

int closedSize;

void setup() {
  size(1500, 1500);
  background(255);
  noStroke();
  
  randomSeed(runs);
  noiseSeed((long)random(5000));
  runs++;
  
  grid = new Grid(gridwidth, gridheight);
  finished = false;
  nosolution = false;
  openSet = new ArrayList<Node>();
  iteration = 0;
  wait = restartdelay;
  closedSize = 0;
  
  openSet.add(grid.start);
}

void draw() {
  background(255);
  
  if (finished || nosolution) {
    if (!loop) {
      noLoop();
      Show();
      return;
    }
    if (wait != 0) {
      wait--;
    } else {
      setup();
      return;
    }
  } else {
    paths = new ArrayList<ArrayList<Node>>();
    for (int i = 0; i < stepsPerFrame; i++) {
      
      Pathfind(true);
      paths.add(ClonePath(path));
      if (finished || nosolution) {
        animate = false;
        break;
      }
    }
  }
  
  Show();
}

void Show() {
  grid.Show();
  DrawPath();
  ShowDebug();
}

void ShowDebug() {
  DebugItem[] items = {
    new DebugItem("FPS", (float)floor(frameRate * 10) / 10),
    new DebugItem("Lowest F score", (float)floor(GetLowestF().f * 10) / 10),
    new DebugItem("Highest G score", (float)floor(GetHighestG().g * 10) / 10),
    new DebugItem("Closed set size", closedSize),
    new DebugItem("Open set size", openSet.size()),
    new DebugItem("Steps", iteration),
    new DebugItem("Steps/frame", stepsPerFrame),
    new DebugItem("Steps/second", stepsPerFrame * frameRate)
  };
  
  fill(0, 150);
  rect(5, 5, debugTextSize * 15, debugTextSize * items.length + 10);
  
  textSize(debugTextSize);
  fill(255);
  
  for (int i = 0; i < items.length; i++) {
    String debug = items[i].name + ": " + items[i].value;
    
    text(debug, 10, debugTextSize * i + debugTextSize + 5);
  }
}

void Pathfind(boolean animating) {
  iteration++;
  
  
  if (openSet.size() == 0) {
    nosolution = true;
    println(runs + ": NO SOLUTION");
    return;
  }
  
  Node current = GetLowestF();
  
  path = new ArrayList<Node>();
  Node temp = current;
  path.add(temp);
  while (temp.previous != null) {
    path.add(temp.previous);
    temp = temp.previous;
  }
  
  if (current == grid.end) {
    finished = true;
    println(runs + ": DONE!");
  } else {
    openSet.remove(openSet.indexOf(current));
    current.closed = true;
    closedSize++;
    current.SetIteration(iteration);
    
    ArrayList<Node> currentneighbors = current.GetNeighbors();
    
    for (int i = 0; i < currentneighbors.size(); i++) {
      Node neighbor = currentneighbors.get(i);
      
      if (!neighbor.closed && !neighbor.obstacle) {
        float tempg = current.g + dist(current.x, current.y, neighbor.x, neighbor.y);
        
        boolean newpath = false;
        if (openSet.contains(neighbor)) {
          if (tempg < neighbor.g) {
            neighbor.g = tempg;
            newpath = true;
          }
        } else {
          neighbor.g = tempg;
          newpath = true;
          openSet.add(neighbor);
          
        }
        
        if (newpath) {
          //neighbor.h = dist(neighbor.x, neighbor.y, grid.end.x, grid.end.y);
          
          float a = max(abs(neighbor.x - grid.end.x), abs(neighbor.y - grid.end.y));
          float b = min(abs(neighbor.x - grid.end.x), abs(neighbor.y - grid.end.y));
          neighbor.h = (a - b) + sqrt(2) * b;
          
          neighbor.f = neighbor.g + neighbor.h;
          
          //neighbor.f = neighbor.g - neighbor.h;
          neighbor.previous = current;
        }
      }
    }
    
    
    
    
  }
}

Node GetLowestF() {
  if (openSet.size() == 0) return grid.end;
  int index = 0;
  
  for (int i = 0; i < openSet.size(); i++) {
    if (openSet.get(i).f < openSet.get(index).f) {
      index = i;
    } else if (openSet.get(i).f == openSet.get(index).f) {
      if (openSet.get(i).h < openSet.get(index).h) {
        index = i;
      }
    }
  }
  
  return openSet.get(index);
}

Node GetHighestF() {
  if (openSet.size() == 0) return grid.end;
  int index = 0;
  
  for (int i = 0; i < openSet.size(); i++) {
    if (openSet.get(i).f > openSet.get(index).f) {
      index = i;
    }
  }
  
  return openSet.get(index);
}

Node GetLowestH() {
  if (openSet.size() == 0) return grid.end;
  int index = 0;
  
  for (int i = 0; i < openSet.size(); i++) {
    if (openSet.get(i).h < openSet.get(index).h) {
      index = i;
    }
  }
  
  return openSet.get(index);
}

Node GetHighestH() {
  if (openSet.size() == 0) return grid.end;
  int index = 0;
  
  for (int i = 0; i < openSet.size(); i++) {
    if (openSet.get(i).h > openSet.get(index).h) {
      index = i;
    }
  }
  
  return openSet.get(index);
}

Node GetLowestG() {
  if (openSet.size() == 0) return grid.end;
  int index = 0;
  
  for (int i = 0; i < openSet.size(); i++) {
    if (openSet.get(i).g < openSet.get(index).g) {
      index = i;
    }
  }
  
  return openSet.get(index);
}

Node GetHighestG() {
  if (openSet.size() == 0) return grid.end;
  int index = 0;
  
  for (int i = 0; i < openSet.size(); i++) {
    if (openSet.get(i).g > openSet.get(index).g) {
      index = i;
    }
  }
  
  return openSet.get(index);
}

void DrawPath() {
  for (int j = 0; j < paths.size(); j++) {
    if (finished) if (paths.get(j).get(0) != path.get(0)) continue;
    for (int i = 0; i < paths.get(j).size() - 1; i++) {
      Node node1 = paths.get(j).get(i);
      Node node2 = paths.get(j).get(i+1);
      stroke(0, 200, 255, 255 / stepsPerFrame);
      strokeWeight(5);
      
      if (finished) {
        stroke(0, 200, 255);
        strokeWeight(10);
      }
      if (nosolution) {
        stroke(255, 0, 100);
        strokeWeight(7);
      }
      
      line(node1.centerScreenX, node1.centerScreenY, node2.centerScreenX, node2.centerScreenY);
      noStroke();
    }
  }
}

ArrayList<Node> ClonePath (ArrayList<Node> origin) {
  ArrayList<Node> clone = new ArrayList<Node>();
  for (int i = 0; i < origin.size(); i++) clone.add(origin.get(i));
  return clone;
}
