import java.awt.MouseInfo; //<>//
import java.awt.Point;

PImage bg; 
int posY;
int posX;

boolean inBody;
ArrayList<PVector> positionsL;
ArrayList<PVector> positionsR;

boolean drawed = false;

String s = "0 qweryuiop 1 qweryuiop 2 qweryuio 3 qweryuio 4 qweryuio 5 qweryuio 6 qweryuio 7 qweryuio 8 qweryuio 9 qweryuio 0";
void setup() {
  size(640, 480);

  positionsL = new ArrayList<PVector>();
  positionsR = new ArrayList<PVector>();

  bg = loadImage("body.png");
  background(0);
}

void draw() {

  background(0);
  int prevPosX;

  positionsR.clear();
  positionsL.clear();

  Point mouse;
  mouse = MouseInfo.getPointerInfo().getLocation();

  image(bg, 0, 0, mouse.x, mouse.y);
  //image(bg, 0, 0, 604, 480);

  //image(bg, 0, 0);

  PVector pL;  
  PVector pR;

  pR = new PVector(0, 0, 0);
  pL = new PVector(0, 0, 0);

  posY=0;
  prevPosX=0;
  loadPixels();
  for (int y = 0; y < height; y++) {
    posX=0;

    for (int x = 0; x < width - 10; x++) {
      //run through all pixels
      int loc = x + y*width;
      int nextLoc = min(x+1, width) + y*width;
      //where body is  //<>//
      if (y % 20 == 0 ) {
        if (brightness(pixels[loc]) > 10) {
          if (posX == 1) {      
            pL = new PVector(x, y, 0);
          }
          if (brightness(pixels[nextLoc]) < 10) {
            pR = new PVector(x, y, 0);
            if (pR.y == pL.y && posX > 5) {
              positionsL.add(pL);
              positionsR.add(pR);
            }
            posX = 0;
          }
          prevPosX = posX;
          posX++;
        }
      }
    }
  }
  updatePixels();

  float totalTextWidth = textWidth(s); 

  float totalWritingSpace = 0;
  float currentWritingSpace =0;
  float charWidthAverage;

  int charNum = 0;

  int charFullLimit = 0;
  int charIndexLimit = 0;

  int badLine;
  String currentString = "";


  for (int i = 0; i < max(positionsL.size(), positionsR.size()); i++) {

    if (positionsL.get(i).y - positionsL.get(max(i-1, 0)).y > 20) {
      //   println(positionsL.get(i).y - positionsL.get(max(i-1, 0)).y);
      //  println("jumped line! - " + i);
    }

    // draw lines
    stroke(255, 255, 0);
    strokeWeight(3);
    line(positionsL.get(i).x, positionsL.get(i).y, positionsR.get(i).x, positionsR.get(i).y);
    stroke(255);
    fill(255, 0, 0);
    //circle points
    ellipse(positionsL.get(i).x, positionsL.get(i).y, 10, 10);
    // id debug
    fill(255, 60, 60);
    text(i, positionsL.get(i).x - 20, positionsL.get(i).y + 5);

    //println(i + ": " + positionsR.get(i));
    stroke(255);
    fill(0, 255, 0);
    ellipse(positionsR.get(i).x, positionsR.get(i).y, 10, 10);
    fill(60, 255, 60);
    text(i, positionsR.get(i).x + 20, positionsR.get(i).y + 5);

    // calculate space for each line
    currentWritingSpace = positionsR.get(i).x - positionsL.get(i).x;
    // average character width
    charWidthAverage = textWidth(s) / s.length();
    // calculate number of charts for each line 
    charIndexLimit = min(charNum+int(currentWritingSpace / charWidthAverage), s.length()); 
    charFullLimit = max(charNum+int(currentWritingSpace / charWidthAverage), charIndexLimit) ;

    currentString = "";

    //calculate number of characters for the current width
    for (int j = charNum; j < charFullLimit; j++) {
      char currentChar;
      currentChar = s.charAt(j % charIndexLimit);


      currentString += str(currentChar);
    }

    fill(255);
    text(currentString, positionsL.get(i).x, positionsL.get(i).y);

    charNum += charIndexLimit;
    if (charNum >= s.length()-2) {
      charNum = 0;
    }
  }
  if (saveEachFrame == true) {
    saveFrame();
  }
  //println("totalWritingSpace: " + totalWritingSpace);
}

boolean saveEachFrame;

void keyPressed() {
  if (key == 's') {
    saveFrame();
  } else 
  if (key == 'S') {
    if (saveEachFrame == true) {
      saveEachFrame = false;
    } else {
      saveEachFrame = true;
    }
  } else {
    for (int i = 0; i < max(positionsL.size(), positionsR.size()); i++) {
      println("L " + i +  ": " + positionsL.get(i) + ", R " + i +  ": " + positionsR.get(i));
    }
  }
}

void mouseMoved() {
  // saveFrame();
}