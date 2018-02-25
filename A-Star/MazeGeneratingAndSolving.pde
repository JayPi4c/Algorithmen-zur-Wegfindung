Cell grid[][];
MazeGenerator MazeGen;


int cols = 20, rows = 20;
int wid, hig;
int w, h;

ArrayList<Cell> openSet = new ArrayList<Cell>();
ArrayList<Cell> closedSet = new ArrayList<Cell>();

Cell start;
Cell end;

Cell current;

ArrayList<Cell> path = new ArrayList<Cell>();

boolean finished = false;

void setup() {
  //frameRate(5);
  size(400, 400);
  wid = width;
  hig = height;

  w = wid/cols;
  h = hig/rows;


  MazeGen = new MazeGenerator(wid, hig, cols, rows);
  reset();
}

void draw() {
  // Am I still searching?
  if (finished) {
    delay(2000);
    finished = false;
  }


  if (openSet.size() > 0) {

    // Best next option
    int winner = 0;
    for (int i = 0; i < openSet.size(); i++) {
      if (openSet.get(i).getF() < openSet.get(winner).getF()) {
        winner = i;
      }
    }
    current = openSet.get(winner);

    // Did I finish?
    if (current == end) {
      //noLoop();
      finished = true;
      println("Astar: DONE!");
    }

    // Best option moves from openSet to closedSet
    openSet.remove(current);
    closedSet.add(current);

    // Check all the neighbors
    ArrayList<Cell> neighbors = current.getNeighbors();
    for (int i = 0; i < neighbors.size(); i++) {
      Cell neighbor = neighbors.get(i);

      // Valid next spot?
      if (!closedSet.contains(neighbor)) {
        float tempG = current.getG() + heuristic(neighbor, current);

        // Is this a better path than before?
        boolean newPath = false;
        if (openSet.contains(neighbor)) {
          if (tempG < neighbor.getG()) {
            neighbor.setG(tempG);
            newPath = true;
          }
        } else {
          neighbor.setG(tempG);
          newPath = true;
          openSet.add(neighbor);
        }

        // Yes, it's a better path
        if (newPath) {
          neighbor.setH(heuristic(neighbor, end));
          neighbor.setF(neighbor.getG() + neighbor.getH());
          neighbor.setPrevious(current);
        }
      }
    }
    // Uh oh, no solution
  } else {
    println("no solution!");
    delay(2000);
    reset();
    //noLoop();
    return;
  }


  // Find the path by working backwards
  path = new ArrayList<Cell>();
  Cell temp = current;
  path.add(temp);
  while (temp.getPrevious() != null) {
    path.add(temp.getPrevious());
    temp = temp.getPrevious();
  }

  //färbe die Zellen je nach Status
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (current.equals(grid[i][j]) && end.equals(grid[i][j])) {
        grid[i][j].show(color(125, 0, 255));
      } else if (start.equals(grid[i][j])) {
        grid[i][j].show(color(255, 255, 0));
      } else if (current.equals(grid[i][j])) {
        grid[i][j].show(color(0, 0, 255));
      } else if (path.contains(grid[i][j])) {
        grid[i][j].show(color(0, 255, 255));
      } else if (end.equals(grid[i][j])) {
        grid[i][j].show(color(255, 0, 255));
      } else if (closedSet.contains(grid[i][j])) {
        grid[i][j].show(color(255, 0, 0));
      } else if (openSet.contains(grid[i][j])) {
        grid[i][j].show(color(0, 255, 0));
      } else {
        grid[i][j].show(color(255));
      }
    }
  }

  if (finished) {
    reset();
  }
}




void reset() {
  // finished = false;
  grid = MazeGen.getMaze();

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].setNeighbors(grid, cols, rows);
    }
  }



  start = grid[(int)random(cols)][(int)random(rows)];//grid[0][0];
  end = grid[(int)random(cols)][(int)random(rows)];//grid[cols-1][rows-1];

  openSet.add(start);
}



float heuristic(Cell a, Cell b) {
  return(abs(a.getI() - b.getI()) + abs(a.getJ() - b.getJ())) ;
}


boolean running = true;
void mouseReleased() {
  if (running) {
    running = false;
    noLoop();
  } else {
    running = true;
    loop();
  }
}