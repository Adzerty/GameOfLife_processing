Cell[] cells;
boolean[] cellsStateBuffer;

int SIZE = 20;

int w, h;

boolean SIMULATE = false;

color BACKGROUND = #333333;
color CELL = #00BB33;

void setup() {
  size(800, 800);
  w = width / SIZE;
  h = height / SIZE;

  cells = new Cell[h * w];
  cellsStateBuffer = new boolean[h * w];

  //Setup cells

  for (int i = 0; i<w; i++) {
    for (int j  = 0; j<h; j++) {
      cells[i * w + j] = new Cell(false, i, j);
    }
  }

  for (int i = 0; i<w; i++) {
    for (int j  = 0; j<h; j++) {
      Cell c = cells[i * w + j];
      if (i > 0) {
        if (j > 0) {
          c.addNeighbour(cells[(i-1)*w + j - 1]);
        }
        c.addNeighbour(cells[(i-1)*w + j]);
        if (j < h - 1) {
          c.addNeighbour(cells[(i-1)*w + j + 1]);
        }
      }

      if (j > 0) {
        c.addNeighbour(cells[(i)*w + j - 1]);
      }

      if (j < h - 1) {
        c.addNeighbour(cells[(i)*w + j + 1]);
      }

      if (i < w - 1) {
        if (j > 0) {
          c.addNeighbour(cells[(i+1)*w + j - 1]);
        }
        c.addNeighbour(cells[(i+1)*w + j]);
        if (j < h - 1) {
          c.addNeighbour(cells[(i+1)*w + j + 1]);
        }
      }
    }
  }
  frameRate(15);
}

void draw() {
  background(BACKGROUND);
  stroke(0);
  for (int i = 0; i<w; i++) {
    for (int j  = 0; j<h; j++) {
      Cell c = cells[i * w + j];
      if (c.alive) {
        fill(CELL);
      } else {
        fill(BACKGROUND);
      }
      rect(i * SIZE, j * SIZE, SIZE, SIZE);

      cellsStateBuffer[i * w + j] = c.computeNewState();
    }
  }

  if (SIMULATE) {
    for (int i = 0; i<w; i++) {
      for (int j  = 0; j<h; j++) {
        cells[i * w + j].alive = cellsStateBuffer[i * w + j];
      }
    }
  }
}

boolean draggedCellState;

void mousePressed() {
  int i = mouseX / SIZE;
  int j = mouseY / SIZE;

  if (i > w || j > h) {
    return;
  }

  draggedCellState = !cells[i * w + j].alive;
}


void mouseDragged() {
  int i = mouseX / SIZE;
  int j = mouseY / SIZE;
  cells[i * w + j].alive =draggedCellState;
}

void reset() {
  for (int i = 0; i<w; i++) {
    for (int j  = 0; j<h; j++) {
      cells[i * w + j].alive = false;
    }
  }
}

void keyPressed() {
  if (keyPressed) {
    if (key == ' ') {
      SIMULATE = !SIMULATE;
    }

    if (key == 'r' || key == 'R') {
      SIMULATE = false;
      reset();
    }
  }
}
