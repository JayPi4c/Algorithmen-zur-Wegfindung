class Knoten {

  float kosten;

  ArrayList<Knoten>verbundeneKnoten;
  ArrayList<Integer> kostenZuKnoten;

  Knoten vorgaenger;

  //boolean besucht;

  char name;
  float x, y;


  public Knoten(char name, float x, float y) {
    // Da es keine unendlich in Processing gibt, wird einfach eine große Zahl verwendet
    kosten = 99999;

    this.vorgaenger = null;
    //besucht = false;

    this.name = name;
    this.x = x;
    this.y = y;
  }


  void setNachbarn(ArrayList<Knoten> verbundeneKnoten, ArrayList<Integer> kostenZuKnoten) {
    this.verbundeneKnoten = verbundeneKnoten;
    this.kostenZuKnoten = kostenZuKnoten;
  }


  void setzeKostenAufNull() {
    kosten = 0;
  }

  void zeigeDich() {
    noStroke();
    fill(0, 0, 255);
    ellipse(x, y, 16, 16);
    stroke(1);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(16);
    text(name, x, y);
  }

  void zeigeVerbindungen() {
    for (int i = 0; i < verbundeneKnoten.size(); i++) {
      stroke(0);
      strokeWeight(2);
      line(x, y, verbundeneKnoten.get(i).x, verbundeneKnoten.get(i).y);
      fill(255, 0, 0);
      textAlign(CENTER, CENTER);
      textSize(16);
      text(kostenZuKnoten.get(i), (x + verbundeneKnoten.get(i).x) /2, (y + verbundeneKnoten.get(i).y) /2);
    }
  }

  void setKosten(float Kosten) {
    kosten = Kosten;
  }

  void setVorgaenger(Knoten k) {
    vorgaenger = k;
  }
}