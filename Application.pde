FloatTable donnees;
float dmin, dmax;
int amin, amax;
int[] annees;
float traceX1, traceY1, traceX2, traceY2;
// La colonne de données actuellement utilisée.
int colonne = 0;
// Le nombre de colonnes.
int ncol;
// La police de caractères.
PFont police;
// intervalle annees
int intervalleAnnees = 10;
// intervalle Volumes
int intervalleVolume = 10;
// intervalle Volume Mineur
int intervalleVolumeMineur = 5;
// Mode de visualisation par défault
int modeVisualisation = 0;
Integrator[] interp;

void setup() {
  size(800, 600);

  donnees = new FloatTable("lait-the-cafe.tsv");
  ncol = donnees.getColumnCount();        // Le nombre de colonnes.
  dmin = 0;
  dmax = dmax = ceil(donnees.getTableMax() / intervalleVolume) * intervalleVolume;
  annees = int(donnees.getRowNames());
  amin = annees[0];
  amax = annees[annees.length - 1];

  interp = new Integrator[donnees.getRowCount()];
  for (int ligne = 0; ligne < donnees.getRowCount(); ligne++) {
    interp[ligne] = new Integrator(0, 0.5, 0.2);
    interp[ligne].target(donnees.getFloat(ligne, colonne));
  }

  traceX1 = 50;
  traceY1 = 50;
  traceX2 = width - 2*traceX1;
  traceY2 = height - traceY1;

  police = createFont("SansSerif", 20);
  textFont(police);

  smooth();
}

void draw() {
  background(224);
  translate(60, 0);
  fill(255);
  rectMode(CORNERS);
  noStroke();
  rect(traceX1, traceY1, traceX2, traceY2);

  for (int i = 0; i < donnees.getRowCount(); i++) {
    interp[i].update();          // mise à jour de l'effet de mouvement
  }

  switch(modeVisualisation) {
  case 0 :
    dessinerModePointLignes();
    break;
  case 1 :
    dessinerModeAire();
    break;
  case 2 :
    dessinerModeHistograme();
    break;
  default :
    dessinerModePointLignes();
    break;
  }
}


void dessinerModePointLignes() {
  dessineTitre();
  dessineLegendeY("Années");
  dessineAxeAnnees();
  dessineLegendeX("Litres \n consommés \n par pers");
  dessineAxeVolume();
  strokeWeight(2);
  stroke(#AB87FF);
  noFill();
  dessineLigneDonnees(colonne);
  strokeWeight(5);
  stroke(#5679C1);
  dessinePointsDonnees(colonne);
}

void dessinerModeAire() {
  strokeWeight(1);
  stroke(#5679C1);
  fill(#5679C1);
  dessineLigneDonneesFill(colonne);
  dessineTitre();
  dessineLegendeY("Années");
  dessineAxeAnnees();
  dessineLegendeX("Litres \n consommés \n par pers");
  dessineAxeVolume();
}

void dessineLigneDonneesFill(int col) {
  beginShape();
  int lignes = donnees.getRowCount();
  for (int ligne = 0; ligne < lignes; ligne++) {
    if (donnees.isValid(ligne, col)) {
      float valeur = interp[ligne].value;
      float x = map(annees[ligne], amin, amax, traceX1, traceX2);
      float y = map(valeur, dmin, dmax, traceY2, traceY1);
      vertex(x, y);
    }
  }
  vertex(traceX2, traceY2);
  vertex(traceX1, traceY2);
  endShape(CLOSE);
}

void dessinerModeHistograme() {
  dessineTitre();
  dessineLegendeY("Années");
  dessineAxeAnnees();
  dessineLegendeX("Litres \n consommés \n par pers");
  dessineAxeVolume();
  noFill();
  strokeWeight(5);
  stroke(#5679C1);
  dessineRectDonnees(colonne);
}

void dessineRectDonnees(int col) {
  int lignes = donnees.getRowCount();
  for (int ligne = 0; ligne < lignes; ligne++) {
    if (donnees.isValid(ligne, col)) {
      float valeur = interp[ligne].value;
      float x = map(annees[ligne], amin, amax, traceX1, traceX2);
      float y = map(valeur, dmin, dmax, traceY2, traceY1);
      rectMode(CORNER);
      rect(x, y, 0, traceY2-y);
    }
  }
}


void dessinePointsDonnees(int col) {
  int lignes = donnees.getRowCount();
  for (int ligne = 0; ligne < lignes; ligne++) {
    if (donnees.isValid(ligne, col)) {
      float valeur = interp[ligne].value;
      float x = map(annees[ligne], amin, amax, traceX1, traceX2);
      float y = map(valeur, dmin, dmax, traceY2, traceY1);
      point(x, y);
    }
  }
}

void dessineLigneDonnees(int col) {
  beginShape();   // On commence la ligne.
  int lignes = donnees.getRowCount();
  for (int ligne = 0; ligne < lignes; ligne++) {
    if (donnees.isValid(ligne, col)) {
      float valeur = interp[ligne].value;
      float x = map(annees[ligne], amin, amax, traceX1, traceX2);
      float y = map(valeur, dmin, dmax, traceY2, traceY1);
      vertex(x, y);
    }
  }
  endShape(); // On termine la ligne sans fermer la forme.
}






// dessine le titre
void dessineTitre() {
  fill(0);
  textSize(20);
  textAlign(LEFT);
  text(donnees.getColumnName(colonne), traceX1, traceY1 - 10);
}



void dessineLegendeX(String legende) {
  textAlign(CENTER, CENTER);
  textSize(10);
  text(legende, traceX1 - 70, height / 2);
}

// dessine axe Volume
void dessineAxeVolume() {
  fill(0);
  textSize(10);
  stroke(128);
  strokeWeight(1);

  for (float v = dmin; v <= dmax; v+=intervalleVolumeMineur) {
    if (v % intervalleVolumeMineur == 0) {
      float y = map(v, dmin, dmax, traceY2, traceY1);
      if (v % intervalleVolume == 0) {
        if (v == dmin) {
          textAlign(RIGHT, BOTTOM);
        } else if (v == dmax) {
          textAlign(RIGHT, TOP);
        } else {
          textAlign(RIGHT, CENTER);
        }
        text(floor(v), traceX1 - 10, y);
        line(traceX1 - 4, y, traceX1, y); // Tiret majeur.
      } else {
        line(traceX1 - 2, y, traceX1, y); // Tiret mineur.
      }
    }
  }
}


void dessineAxeAnnees() {
  fill(0);
  textSize(10);
  textAlign(CENTER, TOP);

  // Des lignes fines en gris clair.
  stroke(224);
  strokeWeight(1);

  int lignes = donnees.getRowCount();
  for (int ligne = 0; ligne < lignes; ligne++) {
    if (annees[ligne] % intervalleAnnees == 0) {
      float x = map(annees[ligne], amin, amax, traceX1, traceX2);
      text(annees[ligne], x, traceY2 + 10);
      // Dessine les lignes.
      line(x, traceY1, x, traceY2);
    }
  }
}


void dessineLegendeY(String legende) {
  textSize(10);
  text(legende, width / 2 - 60, traceY2 + 40);
  textAlign(BASELINE);
}

void keyPressed() {

  if (key == ' ') {
    if (colonne >= ncol-1) {
      colonne = 0;
    } else colonne++;
    for (int ligne = 0; ligne < donnees.getRowCount(); ligne++) {
      interp[ligne].target(donnees.getFloat(ligne, colonne));
    }
  } else {
    if (modeVisualisation >= 2) {
      modeVisualisation = 0;
    } else modeVisualisation++;
  }


 
}
