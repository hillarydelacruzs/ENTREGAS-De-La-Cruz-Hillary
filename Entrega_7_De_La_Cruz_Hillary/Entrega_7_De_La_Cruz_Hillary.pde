// Hillary De La Cruz - 202222142

Table tabla;
int[] counts = new int[6];
String[] nombres = { "joy", "fear", "love", "anger", "sadness", "surprise" };
// Colores base
color[] cols = {
  color(255, 100, 100),
  color(200, 200, 50),
  color(250, 150, 250),
  color(220, 50, 50),
  color(100, 100, 255),
  color(150, 150, 150)
};

// Parámetros mosaico
int scaleFactor = 200;   // tweets
int tiles       = 12;
void setup() {
  size(1000, 700);
  tabla = loadTable("text.csv", "header");
  for (TableRow r : tabla.rows()) counts[r.getInt("label")]++;
  noLoop();
}

void draw() {
  background(30);
  float panelW = width/3.0;
  float panelH = height/2.0;

  // Dibuja 6 paneles
  for (int e = 0; e < 6; e++) {
    int colIdx = e % 3;
    int rowIdx = e / 3;
    float x0 = colIdx * panelW;
    float y0 = rowIdx * panelH;
    drawMosaicPanel(e, x0, y0, panelW, panelH);
  }
}

// Dibuja un panel de mosaico para la emoción e
void drawMosaicPanel(int e, float x0, float y0, float w, float h) {
  int nFilled = counts[e] / scaleFactor;  // cuántas colorear idealmente
  float tileW = w / tiles;
  float tileH = h / tiles;
  float maxDist = dist(0, 0, tiles/2, tiles/2);

  for (int i = 0; i < tiles; i++) {
    for (int j = 0; j < tiles; j++) {
      // distancia al centro de la grilla
      float d = dist(i, j, tiles/2, tiles/2) / maxDist;
      // cuanto más cerca del centro, mayor probabilidad
      float prob = map(d, 0, 1, 0.8, 0.2);
      // modulamos por intensidad de la emoción
      float intensity = constrain(map(counts[e], 0, max(counts), 0, 1), 0, 1);
      if (random(1) < prob * intensity) {
        fill(cols[e]);
      } else {
        fill(20);
      }
      noStroke();
      float x = x0 + j * tileW;
      float y = y0 + i * tileH;
      rect(x, y, tileW, tileH);
    }
  }

  // Texto con el nombre de la emoción, semitransparente
  fill(255, 150);
  textAlign(CENTER, CENTER);
  textSize(16);
  text(nombres[e], x0 + w/2, y0 + h/2);
}
