class Cell {
  
  boolean alive;
  int x, y;
  ArrayList<Cell> neighbours = new ArrayList<>();
  
  public Cell(boolean state, int x, int y){
    this.alive = state;
    this.x = x;
    this.y = y;
  }
  
  public void addNeighbour(Cell neighbour){
    this.neighbours.add(neighbour);
  }
  
  public boolean computeNewState(){
    

    int aliveNeighbours = 0;
    
    
    
    for(Cell n : neighbours){
      aliveNeighbours += n.alive ? 1 : 0;
    }

    return (aliveNeighbours == 3) || (alive && aliveNeighbours == 2);
  }
}
