public class MazeGenerator {


  int wid, hig;
  int cols, rows;
  int w, h;


  Cell grid[][];

  Cell current;
  Cell start;

  ArrayList<Cell> unvisitedSet;
  ArrayList<Cell> stack;

  public MazeGenerator(int wid, int hig, int cols, int rows) {
    this.wid = wid;
    this.hig = hig;
    this.cols = cols;
    this.rows = rows;
    this.w = wid/cols;
    this.h = hig/rows;
  }




  private void createMaze() {
    
    unvisitedSet = new ArrayList<Cell>();
    stack = new ArrayList<Cell>();

    grid = new Cell[cols][rows];

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j] = new Cell(i, j, cols, rows);
        unvisitedSet.add(grid[i][j]);
      }
    }

    start = grid[(int)random(cols)][(int)random(rows)];
    current = start;
    current.setVisited(true);
    unvisitedSet.remove(current);
    
    
    
    while (unvisitedSet.size() > 0) {
      Cell chosen = current.getNeighbor(grid, cols, rows);
      if (chosen != null) {
        stack.add(current);
        current.removeWall(chosen);
        chosen.removeWall(current);
        current = chosen;
        current.setVisited(true);
        unvisitedSet.remove(current);
      } else if (stack.size() > 0) {
        current = stack.remove(stack.size()-1);
      }
    }
  }


  public Cell[][] getMaze() {
    createMaze();
    return grid;
  }


  public void show(Cell [][] grid) {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {

        grid[i][j].show(color(255));
      }
    }
  }
}