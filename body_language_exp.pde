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
  int prevPosX;
}

void draw() {

  background(0);
  int prevPosX;

  positionsR.clear();
  positionsL.clear();

  image(bg, mouseX, mouseY);

  posY=0;
  prevPosX=0;
  loadPixels();
  for (int y = 0; y < height; y++) {
    posX=0;

    for (int x = 0; x < width; x++) {
      //run through all pixels
      int loc = x + y*width;

      int nextLoc = min(x+1, width-1) + y*width;

      //where body is 
      if (y % 25 < 25/2) {
        if (y % 25 == 0 ) {
          posY=0;

          if (brightness(pixels[loc]) > 10) {
            posY++;
          }

          // pixels[loc] = color(255);

          if (posY == 1) {
            pixels[loc] = color(255, 0, 0);
            if (brightness(pixels[nextLoc]) < 10) {
              posX = 0;
              PVector p;
              p = new PVector(x, y, 0);
              positionsR.add(p);
            }
            // println("posX: " + posX); 
            if (posX == 1) {            
              PVector p;
              p = new PVector(x, y, 0);
              positionsL.add(p);
              //  println(posX - prevPosX);
              //       pixels[loc] = color(0, 255, 0);
            }
            prevPosX = posX;

            posX++;
          }
        }
      }
    }
  }
  updatePixels();

  float totalWritingSpace = 0;
  int charNum = 0;

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
    /*    println(i + ": " + positionsL.get(i));
     stroke(255);
     fill(255, 0, 0);
     ellipse(positionsL.get(i).x, positionsL.get(i).y, 10, 10);
     
     println(i + ": " + positionsR.get(i));
     stroke(255);
     fill(0, 255, 0);
     ellipse(positionsR.get(i).x, positionsR.get(i).y, 10, 10);
     
     stroke(255, 255, 0);
     strokeWeight(3);
     line(positionsL.get(i).x, positionsL.get(i).y, positionsR.get(i).x, positionsR.get(i).y);
     */
    float currentWritingSpace =0;
    currentWritingSpace = positionsR.get(i).x - positionsL.get(i).x;
    totalWritingSpace += currentWritingSpace;    

    String currentString = "";

    for (int j = charNum; j < s.length(); j++) {

      char currentChar = s.charAt(j);

      if (textWidth(currentString) > currentWritingSpace) {

        text(currentString, positionsL.get(i).x, positionsL.get(i).y);
      } else {
        if (charNum > s.length() -10) { 
          charNum = 0;
        }
        currentString += str(currentChar);
        charNum ++;
      }
    }
    //  println("line width: " +  textWidth(currentString));
    //  println("char number: " + charNum);
  }
  // println("totalWritingSpace: " + totalWritingSpace);
}