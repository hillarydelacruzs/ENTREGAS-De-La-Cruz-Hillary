//Imagen de referencia 
//https://i.pinimg.com/736x/f7/06/ac/f706acbf10d53a776e77a9d89b8f4536.jpg

void setup () {
size (1000,1000);
background (38,38,40);

//Estrellas
//Utilize la funcion de estrella de la pagina oficial de processing 
//https://processing.org/examples/star.html

// x(500) = centro horizontal en el canvas
//y(500) = verticalmente pocision ene l canvas
//radio1 = la profundidad de las puntas (hace que sea mas puntiaguda o mas redonda)
//radio2=largo de la estrella
// intnpont = numero de puntas

//Colores 
//Rosado (240,55,165)
//azul (26,0,137)
//verde (205,245,100)


//triangulos naranjas de fondo
noStroke();
fill(237,119,60);
//1
triangle(300,0,700,0,500,200);
//stroke(255);
//strokeWeight(3);
//line(320,0,500,180);
//noStroke();

triangle(1000,0,800,0,625,290);
triangle (1000,480,1000,350,655,430);
triangle(1100,900,900,1000,600,600);
triangle(-150,1000,230,1000,270,580);
triangle (0,480,0,200,300,400);
triangle(120,0,265,0,370,250);

//triangulos amarillos fondo
noStroke();
fill(234,193,25);
triangle (1000,800,1000,500,600,550);
triangle(200,1000,700, 1000,440,700);
triangle (1000,80,1000,300,600,340);
triangle (0,800,0,500,260,550);
triangle(-150,100,0,-200,280,330);



stroke(255);
strokeWeight(5);

//ESTRELLA CENTRO
fill(240,55,165);
star(430,470,120,300,6); 

//Ojo centro
noStroke();
fill (26,0,137);
ellipse(430,470,200,120);

//pestañas ojo del centro
fill(205,245,100);
star(430,470,300,50,2); 

//Dentro del ojo 
fill(255);
ellipse(430,470,100,100);
fill(0);
ellipse(430,470,50,30);

//contorno blanco
stroke(255);
strokeWeight(5);

//ESTRELLA SUPERIOR

fill(26,0,137);
star(200,180,60,190,5); 

//Ojo superior
noStroke();
fill (205,245,100);
ellipse(200,180,110,80);

//pestañas ojo superior
fill(240,55,165);
star(200,180,200,20,2); 

//Dentro del ojo 
fill(255);
ellipse(200,180,50,50);
fill(0);
ellipse(200,180,30,20);

//contorno blanco
stroke(255);
strokeWeight(5);

//ESTRELLA INFERIOR
fill(205,245,100);
star(730,750,60,170,5); 

//Ojo inferior
noStroke();
fill (240,55,165);
ellipse(735,750,120,70);

//pestañas ojo inferior
fill(26,0,137);
star(735,750,170,30,2); 

//Dentro del ojo 
fill(255);
ellipse(735,750,60,45);
fill(0);
ellipse(735,750,30,15);

}



//Función para dibujar una estrella = guia para crear
void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle / 2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a + halfAngle) * radius1;
    sy = y + sin(a + halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
