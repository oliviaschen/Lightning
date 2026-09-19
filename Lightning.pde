int startX;
int startY;
int endX;
int endY;

int flash = 0;     
int timer = 0;     

void setup() {
  size(300, 300);
  startX = width/2;
  startY = 0;
}

void draw() {
  drawSkyGradient();

  // slow flash fade
  flash = flash - 1;
  if (flash < 0) flash = 0;

  timer = timer + 1;

  // only update lightning every few frames
  if (timer > 5) {     // bigger number = slower lightning
    timer = 0;

    
    float wiggleX = (float)(Math.random() * (20) - 10);   // -10 to 10
    float moveY   = (float)(Math.random() * (10) + 5);    // 5 to 15

    endX = startX + (int)wiggleX;
    endY = startY + (int)moveY;

   
    strokeWeight(10);
    stroke(255, 255, 255, 20);
    line(startX, startY, endX, endY);

   
    strokeWeight(5);
    stroke(255, 255, 255, 60);
    line(startX, startY, endX, endY);

    // main bolt
    strokeWeight(2);
    stroke(255);
    line(startX, startY, endX, endY);

   
    if (Math.random() < 0.1) {
      drawBranch(endX, endY);
    }

    // update position
    startX = endX;
    startY = endY;

    if (startY > height || Math.random() < 0.005) {
      startX = width/2;
      startY = 0;
      flash = 200;    
    }
  }
}

void drawBranch(int x, int y) {
  int alpha = 180;

  for (int i = 0; i < 8; i++) {

    
    float wiggleX = (float)(Math.random() * (20) - 10);   // -10 to 10
    float moveY   = (float)(Math.random() * (10) + 5);    // 5 to 15

    int newX = x + (int)wiggleX;
    int newY = y + (int)moveY;

    stroke(255, 255, 255, alpha);
    line(x, y, newX, newY);

    x = newX;
    y = newY;

    alpha = alpha - 20;
    if (alpha < 20) alpha = 20;
  }
}

void drawSkyGradient() {
  int r = 10;
  int g = 20;
  int b = 60;

  for (int y = 0; y < height; y++) {
    stroke(r + flash, g + flash, b + flash);
    line(0, y, width, y);

    r = r + 1;
    g = g + 1;
    b = b + 1;

    if (r > 80) r = 80;
    if (g > 120) g = 120;
    if (b > 200) b = 200;
  }
}
