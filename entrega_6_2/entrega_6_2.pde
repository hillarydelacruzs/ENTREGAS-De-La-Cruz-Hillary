PImage imgsemilla, imgbrote, imghada;
Fondo fondo;
HadaImagen hada;
ArrayList<PVector> polvo;  
int estado = 0;  // 0=SEMILLA, 1=BROTE, 2=HADA

void setup() {
  size (800, 600);

 
  //cargar imagenes
imgsemilla = loadImage("semilla.png");
imgbrote   = loadImage("brote.png");
imghada    = loadImage("hada.png");

// 2) Instancia fondo y hada
  fondo = new Fondo(
    color(135, 206, 235),  // cielo
    color(100,  70,  40),  // tierra
    height * 0.6f          // borde entre cielo y tierra
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
  
  // 2) Historia con imágenes
  hada.estado = estado;
  hada.display();
  
  // 3) Polvo de estrellas (solo en estado HADA)
  if (estado == 2) {
    noStroke();
    fill(255,255,150,200);
    for (PVector p : polvo) {
      ellipse(p.x, p.y, 6, 6);
    }
    if (polvo.size() > 300) polvo.remove(0);
  }
}

// ————— Eventos —————

// 1) Planta la semilla: SEMILLA → BROTE
void mousePressed() {
  if (estado == 0) {
    estado = 1;
  }
}

// 2) Revela las alas: BROTE → HADA al presionar 'E'
void keyPressed() {
  if (estado == 1 && (key=='E' || key=='e')) {
    estado = 2;
  }
}

// 3) Deja polvo al arrastrar: solo en HADA
void mouseDragged() {
  if (estado == 2) {
    polvo.add(new PVector(mouseX, mouseY));
  }
}

// ————— Clase Fondo —————
class Fondo {
  color cielo, tierra;
  float borde;
  Fondo(color cC, color cT, float h) {
    cielo  = cC;
    tierra = cT;
    borde  = h;
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
    if      (estado==0) text("Haz clic para plantar la semilla", x, y-100);
    else if (estado==1) text("Presiona E para revelar tus alas",  x, y-100);
    else if (estado==2) text("Arrastra para volar y dejar polvo mágico", x, y-100);
  }
}
