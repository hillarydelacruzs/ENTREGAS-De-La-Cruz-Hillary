//Hillary De La Cruz-202222142

import java.util.ArrayList;

PImage imgsemilla, imgbrote, imghada; //variable para guardar las imagenes
Fondo fondo; //clase de fondo 
HadaImagen hada;
ArrayList<PVector> polvo; //esto son los circulos que simulan el polvo 
int estado = 0;  // 0=SEMILLA, 1=BROTE, 2=HADA //cada fase

void setup() {
  size(800, 600);
  
  //  Carga y redimensiona (¡una sola vez!)
  imgsemilla = loadImage("semilla.png");
  imgsemilla.resize(90, 90);
  
  imgbrote = loadImage("brote.png");
  imgbrote.resize(200, 200);
  
  imghada = loadImage("hada.png");
  imghada.resize(500,500);
  
  //Fase 1: Inicializa fondo y hada
  fondo = new Fondo(
    color(135, 206, 235),  // cielo
    color(100,  70,  40),  // tierra
    height * 0.6f          // separación
  );
  hada = new HadaImagen(
    width/2, height*0.6f - 20,
    imgsemilla, imgbrote, imghada
  );
  
 
  polvo = new ArrayList<PVector>();
  textAlign(CENTER);
  textSize(16);
}

void draw() {
  // 1) Fondo
  fondo.display();
  
//dibuja cada imagen segun el momento 
  hada.estado = estado;
  hada.display();
  
  // 3) Polvo de estrellas (solo en estado HADA)
  if (estado == 2) {
    noStroke();
    fill(255, 255, 150, 200);
    for (PVector p : polvo) {
      ellipse(p.x, p.y, 6, 6);
    }
    if (polvo.size() > 300) polvo.remove(0);
  }
}

// interracciones
void mousePressed() {
  if (estado == 0) estado = 1;
}

void keyPressed() {
  if (estado == 1 && (key=='E' || key=='e')) estado = 2;
}

void mouseDragged() {
  if (estado == 2) polvo.add(new PVector(mouseX, mouseY));
}

// ————— Clase Fondo —————
class Fondo {
  color cielo, tierra;
  float borde;
  Fondo(color c1, color c2, float b) {
    cielo  = c1;
    tierra = c2;
    borde  = b;
  }
  void display() {
    noStroke();
    fill(cielo);
    rect(0, 0, width, borde);
    fill(tierra);
    rect(0, borde, width, height - borde);
  }
}

// ————— Clase HadaImagen —————
class HadaImagen {
  float x, y;
  PImage[] imgs = new PImage[3];
  int estado;
  HadaImagen(float px, float py, PImage s, PImage b, PImage h) {
    x = px;  y = py;
    imgs[0] = s;
    imgs[1] = b;
    imgs[2] = h;
    estado = 0;
  }
  void display() {
    imageMode(CENTER);
    image(imgs[estado], x, y);
    
    // Texto guía
    fill(255);
    if      (estado == 0) text("Haz clic para plantar la semilla",    x, y - 100);
    else if (estado == 1) text("Presiona E para revelar tus alas",   x, y - 100);
    else                  text("Arrastra para volar y dejar polvo mágico", x, y - 100);
  }
}
