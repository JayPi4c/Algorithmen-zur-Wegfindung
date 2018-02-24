// ein globales Array, welches alle Knoten beinhaltet
Knoten knoten[];

// die Anzahl aller Städte
int anzahlStaedte = 10;

// die Anzahl der möglichen Kombinationen
int moeglichkeiten;

// Um die Reihenfolge des aktuellen Weges zu speichern werden die Indices des Weges gespeichert
int weg[];
// Um den besten Weg zu speichern wird die Reihenfolge der Indices des besten Weges gespeichert
int besterWeg[];

// Die Distanz, die beim aktuell bestem Weg gegangen werden muss
float besteDistanz;

// ein Zähler der die bisher gemachten Möglichkeiten mitzählt
int zaehler = 0;


// ein boolean der beobachtet, ob alle Möglichkeiten überprüft wurden
boolean fertig = false;

void setup() {
  // erstelle ein Fenster mit den Maßen 640x360
  size(640, 360);
  //initialisiere das Array mit der Größe der Variable anzahlStaedte
  knoten = new Knoten[anzahlStaedte];
  // Der Weg wird genausoviele Elemente haben wie die anzahl der Städte
  weg = new int[anzahlStaedte];
  //ebenso wird auch der beste Weg genausoviele Elemente aufweisen wie die anzahl Städte
  besterWeg = new int[anzahlStaedte];

  //initialisiere jedes Element des Arrays
  for (int i = 0; i < knoten.length; i++) {
    knoten[i] = new Knoten(random(width), random(height), i);
    // der erste Weg wird festgelegt
    weg[i] = i;
    // es wird angenommen, dass der erste Weg der beste Weg ist, damit man etwas zum vergleichen hat
    besterWeg[i] = i;
  }
  // soviele Möglichkeiten gibt es zu testen
  moeglichkeiten = fakultaet(anzahlStaedte);
  println("Es gibt " + moeglichkeiten + " mögliche Wege!");

  // die Distanz der aktuellen Reihenfolge betrögt:
  besteDistanz = berechneDistanz(knoten, weg);
}

void draw() {
  // zeichne den Hintergrund neu
  background(255);

  //zeichne den aktuelle besten Weg neu
  stroke(0, 255, 0);
  strokeWeight(4);
  noFill();
  beginShape();
  for (int i = 0; i < besterWeg.length; i++) {
    Knoten k = knoten[besterWeg[i]];
    vertex(k.x, k.y);
  }
  endShape();

  // zeichne den aktuellen Weg neu
  stroke(255, 0, 255);
  strokeWeight(2);
  noFill();
  beginShape();
  for (int i = 0; i < weg.length; i++) {
    Knoten k = knoten[weg[i]];
    vertex(k.x, k.y);
  }
  endShape();




  // zeichne alle Knoten neu
  for (Knoten k : knoten) {
    k.zeigeDich();
  }

  //berechne die Distanz des aktuellen Weges
  float d = berechneDistanz(knoten, weg);
  if (d < besteDistanz) {
    besteDistanz = d;
    besterWeg = kopiereArray(weg);
  }

  // mache eine neue Reihenfolge
  neueReihenfolge();

  // gebe aus, wie viel Prozent schon geschaft wurde
  println(nf((100 * ((float)(zaehler) / (float)(moeglichkeiten))), 0, 4), "% abgeschlossen!");


  //wenn der Algorithmus fertig ist, dann nur noch der beste Weg gezeichnet werden
  if (fertig) {

    // zeichne den Hintergrund neu
    background(255);

    //zeichne den aktuelle besten Weg neu
    stroke(0, 255, 0);
    strokeWeight(4);
    noFill();
    beginShape();
    for (int i = 0; i < besterWeg.length; i++) {
      Knoten k = knoten[besterWeg[i]];
      vertex(k.x, k.y);
    }
    endShape();
    // zeichne alle Knoten neu
    for (Knoten k : knoten) {
      k.zeigeDich();
    }
  }
}



void neueReihenfolge() {
  zaehler++;


  // https://www.quora.com/How-would-you-explain-an-algorithm-that-generates-permutations-using-lexicographic-ordering

  int groesstesI = -1;
  for (int i = 0; i < weg.length - 1; i++) {  
    if (weg[i]< weg[i+1]) {
      groesstesI = i;
    }
  }
  if (groesstesI == -1) {
    noLoop();
    println("FERTIG!");
    fertig = true;
    return;
  }

  int groesstesJ = -1;
  for (int j = 0; j < weg.length; j++) {
    if (weg[groesstesI] < weg[j]) {
      groesstesJ = j;
    }
  }

  tausche(weg, groesstesI, groesstesJ);

  int[] arrayEnde = new int[weg.length - (groesstesI + 1)];
  for (int i = groesstesI + 1; i < weg.length; i++) {
    arrayEnde[i - groesstesI - 1] = weg[i];
  }

  ArrayUmkehren(arrayEnde);

  for (int i = (groesstesI + 1); i < weg.length; i++) {
    weg[i] = arrayEnde[i - (groesstesI + 1)];
  }
} 

// es wird die euklidische Distanz (Luftlinie) ermittelt
float berechneDistanz(Knoten[] k, int []weg) {
  float summe = 0;
  for (int i = 0; i < weg.length - 1; i++) {
    int indexKnotenA = weg[i];
    Knoten A = k[indexKnotenA];
    int indexKnotenB = weg[i+1];
    Knoten B = k[indexKnotenB];
    float d = A.berechneDistanz(B);
    summe += d;
  }
  return summe;
}




//------   einige Funktionen, die so nicht bei Java an Bord sind   ------


void tausche(int array[], int i, int j) {
  int tmp = array[i];
  array[i] = array[j];
  array[j] = tmp;
}




int fakultaet(int n) {
  if ( n == 0 || n == 1)
    return 1;
  return n * fakultaet(n-1);
}

int[] kopiereArray(int array[]) {
  int [] temp = new int[array.length];
  for (int i = 0; i < array.length; i++) {
    temp[i] = array[i];
  }
  return temp;
}


void ArrayUmkehren(int [] array) {
  for (int i = 0; i < array.length / 2; i++)
  {
    int temp = array[i];
    array[i] = array[array.length - i - 1];
    array[array.length - i - 1] = temp;
  }
}