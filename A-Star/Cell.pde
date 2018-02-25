public class Cell {

  private final static int NORTH = 0;
  private final static int EAST = 1;
  private final static int SOUTH = 2;
  private final static int WEST = 3;

  private int i, j;
  private int w, h;

  private boolean visited = false;

  private boolean walls[] = {true, true, true, true};


  private float f = 0, g = 0, h_ = 0;

  private ArrayList<Cell> neighbors = new ArrayList<Cell>();
  private Cell previous = null;



  public void setF(float f) {
    this.f = f;
  }

  public float getF() {
    return f;
  }

  public void setG(float g) {
    this.g = g;
  }

  public float getG() {
    return g;
  }

  public void setH(float h_) {
    this.h_ = h_;
  }

  public float getH() {
    return h_;
  }


  public ArrayList<Cell> getNeighbors() {
    return neighbors;
  }


  public void setPrevious(Cell c) {
    previous = c;
  }


  public Cell getPrevious() {
    return previous;
  }







  public void setNeighbors(Cell[][] grid, int cols, int rows) {
    if (this.i < cols-1 && !walls[EAST]) {
      neighbors.add(grid[i+1][j]);
    }
    if (this.i > 0 && !walls[WEST]) {
      neighbors.add(grid[i-1][j]);
    }
    if (this.j < rows-1 && !walls[SOUTH]) {
      neighbors.add(grid[i][j+1]);
    }
    if (this.j > 0 && !walls[NORTH]) {
      neighbors.add(grid[i][j-1]);
    }
  }




  public Cell(int i, int j, int w, int h) {
    this.i = i;
    this.j = j;
    this.w = w;
    this.h = h;
  }



  public Cell getNeighbor(Cell grid[][], int cols, int rows) {
    ArrayList<Cell> temp = new ArrayList<Cell>();
    if (i-1 >= 0 && !grid[i-1][j].isVisited())
      temp.add(grid[i-1][j]);
    if (j-1 >= 0 && !grid[i][j-1].isVisited())
      temp.add(grid[i][j-1]);
    if (j+1 < rows && !grid[i][j+1].isVisited())
      temp.add(grid[i][j+1]);
    if (i+1 < cols && !grid[i+1][j].isVisited())
      temp.add(grid[i+1][j]);
    return (temp.size() > 0 ? temp.get((int)random(temp.size())) : null);
  }


  public void removeWall(Cell c) {
    if (c.getI() - i == 1)
      walls[EAST] = false;
    else if (c.getI() - i == -1)
      walls[WEST] = false;
    else if (c.getJ() - j == 1)
      walls[SOUTH] = false;
    else
      walls[NORTH] = false;
  }


  public void show(color c) {
    noStroke();
    fill(c);
    rect(i*w, j*h, (i+1)*w, (j+1)*h);
    stroke(0);//color(255, 0, 0));
    if (wallAt(NORTH))
      line(i*w, j*h, (i+1)*w, j*h);
    if (wallAt(EAST))
      line((i+1)*w, j*h, (i+1)*w, (j+1)*h);
    if (wallAt(SOUTH))
      line(i*w, (j+1)*h, (i+1)*w, (j+1)*h);
    if (wallAt(WEST))
      line(i*w, j*h, i*w, (j+1)*h);
  }  






  private int getI() {
    return i;
  }

  private int getJ() {
    return j;
  }

  public boolean isVisited() {
    return visited;
  }

  public void setVisited(boolean b) {
    visited = b;
  }

  private boolean wallAt(int index) {
    return walls[index];
  }


  public void setWallsOnEdges() {
    walls[NORTH] = true;
    walls[SOUTH] = true;
    walls[EAST] = true;
    walls[WEST] = true;
  }
}