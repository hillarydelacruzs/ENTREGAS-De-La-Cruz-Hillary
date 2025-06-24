//Hillary De La Cruz-202222142

//Imagen de referente:

//Variables 
float[] x=new float[4]; //pocision vertical

float[] y=new float[4];

float[] speed= new float[4];

color[]eyeColors=new color[4];

void setup() {
  size(800,600);
  colorMode(HSB,300,100,100); //cambiar los colores 
  noStroke();
  
  for (int i = 0; i < 4; i++) {
    x[i] = width / 5 * (i + 1); //aqui el 5 me esta dividiendo la pantalla para que cada ojo este en un lugar
                                //y el 1 me esta indicando donde empieza el movimiento
                                
    y[i] = height / 3;          // este 3 me esta indicando la altura de los ojos
    
    speed[i] = random(0.5, 1.5); // Movimiento random con un intervalo de cada ojo
    
    eyeColors[i] = color(random(360), 80, 100); // Tonos distintos para la linterna
    
  }
}

void draw () {
  background (0);
  
  //movimiento del ojo
  for (int i = 0; i < 4; i++) { //bucle para dibujar los ojos
    x[i] += sin(frameCount * 0.02 * speed[i]) * 0.8; //ojo se mueva de izquiera a derecha
    
    // Dibujar la linterna 
    fill(eyeColors[i], 50); //color especifico de cada ojo y la intensidad de la linterna
    beginShape();
    vertex(x[i] - 30, y[i]);
    vertex(x[i] + 30, y[i]);
    vertex(x[i] + 70, height);
    vertex(x[i] - 70, height);
    endShape(CLOSE);

//Ojos
    fill(0, 0, 100); // blanco del ojo
    ellipse(x[i], y[i], 60, 40);

    // Iris
    fill(eyeColors[i]);
    ellipse(x[i], y[i], 20, 20);

    // Pupila
    fill(0);
    ellipse(x[i], y[i], 10, 10);
    
    if (x[i] > 300 && x[i] < 500) {
  star(x[i], y[i] + 160, 10, 25, 5);
  fill(234,1930,25); // amarillo
  
}
  }
}
    void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
