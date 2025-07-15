//Hillary De La Cruz-202222142
//Like him es una cancion que habla acerca de cuestionarse si
//te pareces a tu figura paterna por eso inclui dos figuras que se persiguen
//a lo largo de la historia.

import processing.sound.*;

//  Variables de sonido
SoundFile soundfile;
FFT fft;
int bands = 512;
float[] spectrum = new float[bands]; //representa las bandas de frecuencia

//Figuras que se siguen
PVector lider;
PVector seguidor;

void setup() {
  size(800, 800);
  background(0);


  soundfile = new SoundFile(this, "likehim.mp3");
  fft = new FFT(this, bands);
  fft.input(soundfile);
  soundfile.play();

  lider = new PVector(width / 2, height / 2);
  seguidor = new PVector(width / 2, height / 2);
}

void draw() {
  fft.analyze(spectrum);
  float tiempo = soundfile.position() / 1000.0; //esto es para poner cosas en parte especificas

  // Fondo con rastros
  background(0, 30);

  //(frecuencias bajas)
  float lowFreq = spectrum[5];
  float pulso = map(lowFreq, 0, 0.1, 100, 300);
  noStroke();
  fill(255, 255, 255, 10);
  ellipse(width / 2, height / 2, pulso, pulso);


  // 2. ONDA SUAVE (voz femenina al principio)

  if (tiempo < 0.015) {
    float voiceLevel = spectrum[20];
    float waveHeight = voiceLevel * 400;

    stroke(100, 150, 255, 120);
    strokeWeight(2);
    noFill();
    beginShape();
    for (int i = 0; i < width; i += 20) {
      float y = height / 2 + sin(i * 0.03 + frameCount * 0.02) * waveHeight;
      curveVertex(i, y);
    }
    endShape();
  }


  // 3. FIGURAS QUE SE SIGUEN
 
  lider.x = width / 2 + sin(frameCount * 0.01) * 150;
  lider.y = height / 2 + cos(frameCount * 0.008) * 100;
  seguidor.x = lerp(seguidor.x, lider.x, 0.05);
  seguidor.y = lerp(seguidor.y, lider.y, 0.05);

  if (tiempo < 0.015) {
    fill(255, 150);
    ellipse(lider.x, lider.y, 20, 20);
    fill(200, 100, 200, 100);
    ellipse(seguidor.x, seguidor.y, 15, 15);
  } else {
    //Después del segundo 0.015 se agrandan
    float distancia = dist(lider.x, lider.y, seguidor.x, seguidor.y);
    float escala = map(distancia, 0, 200, 60, 30);
    fill(255, 180);
    ellipse(lider.x, lider.y, escala + 20, escala + 20);
    fill(200, 100, 200, 150);
    ellipse(seguidor.x, seguidor.y, escala, escala);
    stroke(255, 100);
    line(lider.x, lider.y, seguidor.x, seguidor.y);
  }

 
  // 4. LÍNEAS VERTICALES (piano después del segundo 0.015)
  if (tiempo >= 0.015) {
    float piano = spectrum[40];
    stroke(255, 100);
    strokeWeight(1);
    for (int i = 0; i < width; i += 15) {
      float h = map(piano, 0, 0.1, 20, height);
      line(i, height / 2 - h / 2, i, height / 2 + h / 2);
    }
  }

  //frecuencias bajas
 
  int numEcos = 50;
  for (int i = 0; i < numEcos; i++) {
    float angle = TWO_PI * i / numEcos;
    float len = lowFreq * 400 + random(10);
    float ex = width / 2 + cos(angle) * len;
    float ey = height / 2 + sin(angle) * len;
    stroke(255, 150, 200, 30);
    strokeWeight(2);
    line(width / 2, height / 2, ex, ey);
  }

  //frecuencias altas
  if (spectrum[300] > 0.02) {
    float y = random(height);
    float longLine = map(spectrum[300], 0, 0.1, 50, width);
    stroke(255, 255, 0, 100);
    strokeWeight(2);
    line(width / 2 - longLine / 2, y, width / 2 + longLine / 2, y);
    
    if (lowFreq > 0.015 && tiempo < 60) {
      float alpha = map(lowFreq, 0.015, 0.05, 10, 50); // transparencia moderada
      float tam = map(lowFreq, 0.015, 0.05, 50, 150);  // tamaño moderado
      noStroke();
      fill(180, 180, 255, alpha);
      ellipse(width/2 + random(-50, 50), height/2 + random(-50, 50), tam, tam);
    }

    if (spectrum[100] > 0.08) {
      background(255, 0, 50, 60);  // efecto tipo flash
    }
  }
}
