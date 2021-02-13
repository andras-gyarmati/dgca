// differential growth cellular automata //<>//

int cellSize, cols, rows;
Cell[][] grid;
ArrayList<Cell> cells;

void setup() {
  size(1000, 1000);
  surface.setLocation(10, 10);
  fill(0);
  noStroke();
  //frameRate(2);
  //noLoop();

  cellSize = 5;
  cols = width / cellSize;
  rows = height / cellSize;
  grid = new Cell[cols][rows];
  cells = new ArrayList<Cell>();
  init();
}

void mouseClicked() {
  redraw();
}

void init() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = new Cell(i, j);
      // the general equation for a circle is (x - h)^2 + (y - k)^2 = r^2
      // where (h, k) is the center and r is the radius
      float x = i * cellSize;
      float y = j * cellSize;
      float h = width / 2f;
      float k = height / 2f;
      float r2 = pow(100, 2);
      float epsilon = 50000; // something is wrong, this is too big(?)
      if (abs(r2 - (pow(x - h, 2) + pow(y - k, 2))) < epsilon) {
        grid[i][j].isAlive = true;
        cells.add(grid[i][j]);
      }
    }
  }
}

void draw() {
  background(255);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (grid[i][j].isAlive) {
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      }
    }
  }
  update();
}

// mindegyik elo cellara megkeresni a legkozelebbi szomszedot ha nincs a kozvetlen kozeleben
// akkor addig menni arrafele fel vagy jobbra eppen amelyikkel messzebb vagyunk hogy
// mindegyiknek ket szomszedja legyen 

Cell findClosest(Cell c) {
  return c; //todo
}

void update() {
  /*for (int k = cells.size() - 1; k >= 0; k--) {
   Cell c = cells.get(k);
   Cell closest = findClosest(c);
   //bridge the gap
   }*/

  Cell[][] prev = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      Cell n = new Cell(i, j);
      prev[i][j] = n;
      n.isAlive = grid[i][j].isAlive;
    }
  }

  for (int k = cells.size() - 1; k >= 0; k--) {
    Cell c = cells.get(k);
    int x = 0;
    int y = 0;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (prev[c.x + i][c.y + j].isAlive) {
          x -= i;
          y -= j;
        }
      }
    }

    x = x < 0 ? -1 : x > 0 ? 1 : 0;
    y = y < 0 ? -1 : y > 0 ? 1 : 0;

    if (x != 0 || y != 0) {
      c.isAlive = false;
      cells.remove(c);
      Cell n = grid[c.x + x][c.y + y];
      n.isAlive = true;
      cells.add(n);
    }
  }
}

class Cell {
  int x, y;
  boolean isAlive;

  Cell(int x, int y) {
    this.x = x;
    this.y = y;
    this.isAlive = false;
  }
}

/*
  // notes
  
  boolean allOk;
  do {
    allOk = true;
    for (int k = cells.size() - 1; k >= 0; k--) {
      Cell c = cells.get(k);
      boolean found = false;
      int dx = 0;
      int dy = 0;
      int r = 1;
      while (!found) {
        for (int i = -r; i <= r; i++) {
          for (int j = -r; j <= r; j++) {
            if (!found && (i > r-1 || j > r-1) && grid[c.x + i][c.y + j].isAlive) {
              found = true;
              dx = i;
              dy = j;
            }
          }
        }
        r++;
      }
      if (found) {
        if (abs(dx) > abs(dy)) {
          if (dx < 0) 
            dx = -1;
          else if (dx > 0) 
            dx = 1;
          Cell n = grid[c.x + dx][c.y];
          n.isAlive = true;
          cells.add(n);
        } else {
          if (dy < 0) 
            dy = -1;
          else if (dy > 0) 
            dy = 1;
          Cell n = grid[c.x][c.y + dy];
          n.isAlive = true;
          cells.add(n);
        }
      }
    }
  } while (!allOk);




    if (x < 0) 
      x = -1;
    else if (x > 0) 
      x = 1;

    if (y < 0) 
      y = -1;
    else if (y > 0) 
      y = 1;

*/
