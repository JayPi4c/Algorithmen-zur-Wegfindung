ArrayList<Knoten> unbesuchteKnoten;

Knoten A, B, C, D, E, F, G;

Knoten aktueller;
Knoten Ziel;


void setup() {
  size(640, 360);
  A = new Knoten('A', 20, 180);
  B = new Knoten('B', 280, 20);
  C = new Knoten('C', 200, 180);
  D = new Knoten('D', 200, 340);
  E = new Knoten('E', 360, 180);
  F = new Knoten('F', 600, 180);
  G = new Knoten('G', 400, 340);


  //setze Verbindungen mit Knoten A
  ArrayList<Knoten> verbundene = new ArrayList<Knoten>();
  verbundene.add(C);
  verbundene.add(D);
  ArrayList<Integer> kosten = new ArrayList<Integer>();
  kosten.add(1);
  kosten.add(2);
  A.setNachbarn(verbundene, kosten);



// Da die Verbindungen von beiden Knoten ausgehen ist es möglich in beide Richtungen zu gehen, wenn man aber
// eine Richtung herausnimmt, entspricht die Verbindung einer Einbahnstraße, da das hier aber nicht berücksichtigt
// werden soll, sind hier die Verbindungen in beide Richtungen gesetzt.


  //setze Verbindungen mit Knoten B
  verbundene = new ArrayList<Knoten>();
  verbundene.add(C);
  verbundene.add(F);
  kosten = new ArrayList<Integer>();
  kosten.add(2);
  kosten.add(3);
  B.setNachbarn(verbundene, kosten);

  //setze Verbindungen mit Knoten C
  verbundene = new ArrayList<Knoten>();
  verbundene.add(A);
  verbundene.add(B);
  verbundene.add(D);
  verbundene.add(E);
  kosten = new ArrayList<Integer>();
  kosten.add(1);
  kosten.add(2);
  kosten.add(1);
  kosten.add(3);
  C.setNachbarn(verbundene, kosten);

  // setze Verbindungen mit Knoten D
  verbundene = new ArrayList<Knoten>();
  verbundene.add(A);
  verbundene.add(C);
  verbundene.add(G);
  kosten = new ArrayList<Integer>();
  kosten.add(2);
  kosten.add(1);
  kosten.add(1);
  D.setNachbarn(verbundene, kosten);

  //setze Verbindungen mit Knoten E
  verbundene = new ArrayList<Knoten>();
  verbundene.add(C);
  verbundene.add(F);
  kosten = new ArrayList<Integer>();
  kosten.add(3);
  kosten.add(2);
  E.setNachbarn(verbundene, kosten);

  //setze Verbindungen mit Knoten F
  verbundene = new ArrayList<Knoten>();
  verbundene.add(B);
  verbundene.add(E);
  verbundene.add(G);
  kosten = new ArrayList<Integer>();
  kosten.add(3);
  kosten.add(2);
  kosten.add(1);
  F.setNachbarn(verbundene, kosten);

  //setze Verbindungen mit Knoten G
  verbundene = new ArrayList<Knoten>();
  verbundene.add(D);
  verbundene.add(F);
  kosten = new ArrayList<Integer>();
  kosten.add(1);
  kosten.add(1);
  G.setNachbarn(verbundene, kosten);


  unbesuchteKnoten = new ArrayList<Knoten>();
  unbesuchteKnoten.add(A);
  unbesuchteKnoten.add(B);
  unbesuchteKnoten.add(C);
  unbesuchteKnoten.add(D);
  unbesuchteKnoten.add(E);
  unbesuchteKnoten.add(F);
  unbesuchteKnoten.add(G);



  aktueller = A;
  aktueller.setzeKostenAufNull();
  Ziel = F;
}


void draw() {
  println(unbesuchteKnoten.size());
  if (unbesuchteKnoten.size() > 0) {
    unbesuchteKnoten.remove(aktueller);
    println(aktueller.name + " " + aktueller.kosten);
    if (aktueller == Ziel) {
      println("angekommen");
      noLoop();
      return;
    }

    for (int i = 0; i < aktueller.verbundeneKnoten.size(); i++) {
      Knoten k = aktueller.verbundeneKnoten.get(i);
      if (unbesuchteKnoten.contains(k)) {
        float kosten = aktueller.kosten + aktueller.kostenZuKnoten.get(i);
        if (k.kosten > kosten) {
          k.setKosten(kosten);
          k.setVorgaenger(aktueller);
        }
      }
    }

    Knoten k = unbesuchteKnoten.get(0);
    for (int i = 0; i < unbesuchteKnoten.size(); i++) {
      if (k.kosten > unbesuchteKnoten.get(i).kosten) {
        k = unbesuchteKnoten.get(i);
      }
    }
    aktueller = k;
  } else {
    println("Kein Weg möglich");
    noLoop();
    return;
  }


  // zeiche es grafisch
  show();
  delay(1000);
}






void show() {
  background(255);
  zeigeKnoten();
  Knoten k = aktueller;
  while (k.vorgaenger != null) {
    stroke(0, 220, 0);
    line(k.x, k.y, k.vorgaenger.x, k.vorgaenger.y);
    k = k.vorgaenger;
  }
}









void zeigeKnoten() {
  A.zeigeVerbindungen();
  B.zeigeVerbindungen();
  C.zeigeVerbindungen();
  D.zeigeVerbindungen();
  E.zeigeVerbindungen();
  F.zeigeVerbindungen();
  G.zeigeVerbindungen();

  A.zeigeDich();
  B.zeigeDich();
  C.zeigeDich();
  D.zeigeDich();
  E.zeigeDich();
  F.zeigeDich();
  G.zeigeDich();
}
