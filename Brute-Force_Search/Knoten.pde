class Knoten {
  float x, y;
  float r = 20;

  int index;

  public Knoten(float x, float y, int i) {
    this.x = x;
    this.y = y;
    index = i;
  }

  void zeigeDich() {
    fill(0, 0, 200);
    noStroke();
    ellipse(x, y, r, r);
    fill(0);
    stroke(0);
    textAlign(CENTER, CENTER);
    textSize(16);
    text("" + index, x, y);
  }

  float berechneDistanz(Knoten k) {
    return dist(x, y, k.x, k.y);
  }
}