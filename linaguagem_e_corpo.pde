import java.awt.MouseInfo;
import java.awt.Point;

PImage bg; 
int posY;
int posX;

boolean inBody;
ArrayList<PVector> positionsL;
ArrayList<PVector> positionsR;

String s = "Agora eu vou testar como os caracteres se comportam formatados em um corpo e nada vai empedir que todos nós sejamos imortais";
void setup() {
  size(640, 480);

  positionsL = new ArrayList<PVector>();
  positionsR = new ArrayList<PVector>();

  bg = loadImage("body.png");
  
}
  
  void draw() {

  background(0);
  int prevPosX;

  positionsR.clear();
  positionsL.clear();

  Point mouse;
  mouse = MouseInfo.getPointerInfo().getLocation();

  image(bg, 0, 0, mouse.x, mouse.y);
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

    for (int x = 0; x < width; x++) {
      //run through all pixels
      int loc = x + y*width;

      int nextLoc = min(x+1, width) + y*width;

      //where body is 
      if (y % 20 < 20/2) {
        if (y % 20 == 0 ) {
          posY=0;

          if (brightness(pixels[loc]) > 10) {
            posY++;
          }

          // pixels[loc] = color(255);

          if (posY == 1) {

            // pixels[loc] = color(255, 0, 0);          
            // println("posX: " + posX); 
            if (posX == 1) {      

              pL = new PVector(x, y, 0);

              //  println(posX - prevPosX);
              //       pixels[loc] = color(0, 255, 0);
            }
            if (brightness(pixels[nextLoc]) < 10) {
              pR = new PVector(x, y, 0);

              //     if (pR.y != pL.y) {
              //       println("unequal y");
              //     }
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
  }
  updatePixels();

  float totalTextWidth = textWidth(s); 

  float totalWritingSpace = 0;
  float currentWritingSpace =0;
  float charWidthAverage;

  int charNum = 0;
  int charLimit = 0;

  String currentString = "";


  for (int i = 0; i < min(positionsL.size(), positionsR.size()); i++) {
    /*   if ((i+1) % 4 == 0) {
     noFill();
     stroke(random(255),random(255),random(255));
     float x = positions.get(i-3).x;
     float y = positions.get(i-3).y;
     float x2 = positions.get(i).x;
     float y2 = y + 30;
     
     quad(x, y, x2, y, x2, y2, x, y2);
     }*/
    //println(i + ": " + positionsL.get(i));
    stroke(255, 255, 0);
    strokeWeight(3);
    line(positionsL.get(i).x, positionsL.get(i).y, positionsR.get(i).x, positionsR.get(i).y);

    stroke(255);
    fill(255, 0, 0);
    ellipse(positionsL.get(i).x, positionsL.get(i).y, 10, 10);

    //println(i + ": " + positionsR.get(i));
    stroke(255);
    fill(0, 255, 0);
    ellipse(positionsR.get(i).x, positionsR.get(i).y, 10, 10);

    currentWritingSpace =0;
    totalWritingSpace += currentWritingSpace;
    currentWritingSpace = positionsR.get(i).x - positionsL.get(i).x;
  //  println("currentWritingSpace: " + currentWritingSpace);

    charWidthAverage = textWidth(s) / s.length();
   // println("charWidthAverage: " + charWidthAverage);

    charLimit = min(charNum+int(currentWritingSpace / charWidthAverage), s.length()); 
    //println("charLimit: " + charLimit);
    //println("charNum: " + charNum);

    currentString = "";

    //calculate number of characters for the current width

    for (int j = charNum; j < charLimit; j++) {
    //  println(j);
      char currentChar = s.charAt(j);

      if (textWidth(currentString) > currentWritingSpace) {
        fill(255, 200, 200);
        currentString += str(currentChar);
      } else {       
        currentString += str(currentChar);
   //     println("currentString: " + currentString);
      }
    }
    fill(255);
    text(currentString, positionsL.get(i).x, positionsL.get(i).y);

    //println("line width: " +  textWidth(currentString));
    //println("char number: " + charNum);
    charNum += charLimit;
    if (charNum >= s.length()-2) {
      charNum = 0;
    }
  }
  //println("totalWritingSpace: " + totalWritingSpace);
}


void mouseMoved() {
  // saveFrame();
}
