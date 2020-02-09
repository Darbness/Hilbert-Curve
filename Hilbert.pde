// Hilbert Curve
// Coding in the Cabana
// The Coding Train / Daniel Shiffman
// https://thecodingtrain.com/CodingInTheCabana/003-hilbert-curve.html
// https://youtu.be/

// Processing Sketch: https://github.com/CodingTrain/website/tree/master/CodingInTheCabana/Cabana_003_Hilbert_Curve/Processing
// p5js Sketch: https://editor.p5js.org/codingtrain/sketches/LPf9PLmp

// Made to draw an image by Darbness

PImage img;
int order = 9;
int N = int(pow(2, order));
int total = N * N;
int tempColor;
int counter = 0;

PVector[] path = new PVector[total];

void setup() {
  img = loadImage("moonwalk.jpg");
  size(1024, 1024);
  selectInput("Select a file to process:", "fileSelected");
  //surface.setResizable(true);
  //surface.setSize(img.width, img.height);
  img.resize(1024,1024);
  background(0);
  for (int i = 0; i < total; i++) {
    path[i] = hilbert(i);
    float len = width / N;
    path[i].mult(len);
    path[i].add(len/2, len/2);
  }
}


void draw() {
  
  background(0);

  stroke(255);
  strokeWeight(1);
  noFill();
  //beginShape();
  for (int i = 1; i < counter; i++) {
    tempColor = img.get((int)path[i].x,(int) path[i].y);
    stroke(tempColor);
    line(path[i].x, path[i].y, path[i-1].x, path[i-1].y);
  }

  counter+=500;
  if (counter >= path.length) {
    counter = path.length;
  }
}


PVector hilbert(int i) {
  PVector[] points = {
    new PVector(0, 0), 
    new PVector(0, 1), 
    new PVector(1, 1), 
    new PVector(1, 0)
  };

  int index = i & 3;
  PVector v = points[index];

  for (int j = 1; j < order; j++) {
    i = i >>> 2;
    index = i & 3;
    float len = pow(2, j);
    if (index == 0) {
      float temp = v.x;
      v.x = v.y;
      v.y = temp;
    } else if (index == 1) {
      v.y += len;
    } else if (index == 2) {
      v.x += len;
      v.y += len;
    } else if (index == 3) {
      float temp = len - 1 - v.x;
      v.x = len - 1 - v.y;
      v.y = temp;
      v.x += len;
    }
  }
  return v;
}

void mousePressed() {
  pickImage();
}

void pickImage() {
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    img = loadImage(selection.getAbsolutePath());
    img.resize(1024,1024);
    counter = 0;
    //surface.setSize(img.width, img.height);
  }
}
