int puntos = 0;
int tiempo = 1500;
int pantalla = 0;
int marcador = 0;
int a = 1;
float angulo = 0;
float gravedad = 100;
float px;
float py;
PImage fondo;
PImage fondo1;
PImage fondo2;
PImage termina;
PImage prepara;
PImage lanza;

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
ArrayList<Boundary> boundaries;
ArrayList<Box> boxes; 

void setup() {
  cursor(CROSS);
  size(880, 360);
  smooth(2);

  fondo =  loadImage("BasquetAjuste.jpg");
  fondo1 = loadImage("start.jpg");
  fondo2 = loadImage("Listo.jpg");
  termina= loadImage("acabar.png");
  lanza =  loadImage("bryant.png");
  prepara= loadImage("prepara.png");

  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();

  impacto();
}

void draw() {

  pantallas();

  box2d.step();

  juego();

  for (Boundary wall : boundaries) {
    wall.display();
  }

  for (Box b : boxes) {
    b.display();
  }

  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }

  box2d.setGravity(0, - 100);

  tiempo();
  //marcador();
}

void marcador() {
  if (px <= 740) {
    if (px >= 665) {
      if (py <= 122) {
        if (py >= 120) {
          marcador = 1;
        }
      }
    }
  }

  if (pantalla == 2) {

    fill(255);
    textSize(22);
    text("Canastas:", 200, 30);
    fill(255);
    textSize(32);
    text(marcador, 310, 30);
  }
}

void juego() {
  if (mousePressed) {
    angulo += 1.5;
    if (pantalla == 2) {
    }
  }

  if (mousePressed) {
    if (pantalla == 2) {
      image(prepara, 0, 200, 55, 160);
    }
  } else {
    if (pantalla == 2) {
      image(lanza, 0, 191, 90, 169);
    }
  }
}

void tiempo() {

  if (pantalla == 2) {
    tiempo --;
  }

  if (tiempo <= 0) {
    image(termina, 120, 80, 630, 114);
    pantalla =1;
  }

  if (pantalla == 2) {
    fill(255);
    textSize(22);
    text("Tiempo:", 10, 30);
    fill(255);
    textSize(32);
    text(tiempo/10, 98, 30);
  }
}

void mouseReleased() {
  lanzar();
}

void lanzar() {
  if (pantalla == 2) {
    line(30, 200, 70, 200);
    Box p = new Box(90, 200);
    boxes.add(p);
    angulo = 0;
  }
}

void impacto() {
  boundaries.add(new Boundary(600, 370, 330, 10));
  boundaries.add(new Boundary(730, 80, 6, 70));
  boundaries.add(new Boundary(676, 120, 3, 3));
  boundaries.add(new Boundary(180, 410, 320, 10));
}

void pantallas() {
  if (key == 'a' || key == 'A' ) {
    pantalla = 1;
  }

  if (key == 's' || key == 'S' ) {
    pantalla = 2;
  }

  if (key == 't' || key == 'T' ) {
    pantalla = 0;
  }

  if (key == 'r' || key == 'R' ) {
    tiempo = 1500;
    marcador = 0;
  }


  switch(pantalla) {
  case 0:
    image(fondo1, 0, 0, 880, 360);
    break;

  case 1:
    image(fondo2, 0, 0, 880, 360);
    break;

  case 2:
    image(fondo, 0, 0, 880, 360);
    break;
  }
}
