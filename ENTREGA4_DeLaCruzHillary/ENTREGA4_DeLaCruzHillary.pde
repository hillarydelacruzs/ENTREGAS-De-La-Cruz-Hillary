//Entrega 4: Hillary De La Cruz-202222142

//Concepto: La lectura habla acerca como los calendarios estan diseñados para moldear nuestra vida de manera eficiente domina nuestra vida diaria
//es por eso que mi reloj busca reflejar la sensacion de ansiedad durante mis episodios de imnsonia donde el tiempo se siento lento y astogante.

//"The cult of productivity and our obsession with employing every minute /wisely have become the great unquestioned virtues of our age."

//Referenteshttps://openprocessing.org/sketch/168079

//Variables
int h =hour();
int m = minute ();
int s = second ();

//Paleta de colores
//Bordo: (120, 0, 0)
//Rojo intenso: (193, 18, 31,)
//negro: (27, 23, 23)
//blanco: (237, 235, 221)
//azul (65,0, 245)


void setup () {
  size(800, 800);
  frameRate (60);
}

void draw () {
  int h =hour();
  int m = minute ();
  int s = second ();

  //fondo de flashes por segundo
  if (frameCount %60 == 0) {
    background(65, 0, 245);
  } else {
    background (27, 23, 23);
  }

  //fondo de flashes por minuto
  if (second()== 0) {
    background(193, 18, 31);
  }

  translate (width /2, height /2);

  //segundo en lineas
  strokeWeight(1);
  stroke(237, 235, 221, 70);
  for (int i = 0; i < s; i++) {
    float angle = TWO_PI / 60 * i;
    float r = 200;
    float x = cos(angle) * r;
    float y = sin(angle) * r;
    line(0, 0, x, y);
  }

  // minutos en lineas
  strokeWeight(7);
  stroke(120, 0, 0, 90);
  for (int i = 0; i < m; i++) {
    float angle = TWO_PI / 60 * i;
    float r = 300;
    float x = cos(angle) * r;
    float y = sin(angle) * r;
    line(0, 0, x, y);
  }

  //Horas en circulos

  noStroke();
  for (int i = 0; i < h; i++) {
    float radius = map(i, 0, 23, width / 2, 50); // de afuera hacia el centro
    float angle = map(i, 0, 24, 0, TWO_PI) + frameCount * 0.001; //
    float x = cos(angle) * radius;
    float y = sin(angle) * radius;


    fill(120, 0, 0);
    ellipse(x, y, 40, 40);
  }
}
