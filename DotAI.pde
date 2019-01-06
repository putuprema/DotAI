Population p;
PVector goal;

int gen = 1;

void setup() {
  size(640,480,P2D);
  frameRate(100);
  p = new Population(1000); // CREATE POPULATION OF BALLS
  goal = new PVector(width/2,30);
  //println("maxStep: 1000");
  //println("Gen: ", gen);
}

void draw() {
  background(255);
  
  // draw goal
  fill(255,0,0);
  ellipse(goal.x,goal.y,10,10);
  // end draw goal
  
  // draw obstacble 1
  //fill(0,0,255);
  //rect(20, height/2+50, 480, 10);
  // end draw obstacle 1
  
  // draw obstacle 2
  //rect(200, 120, 440, 10);
  // end draw obstacle 2
  
  if (p.isAllDead()) {
    p.calculateFitness();
    p.naturalSelection();
    p.mutate();
    gen++;
    //println("Gen: ", gen);
  } else {
    p.update();
    p.display();
    textSize(20);
    fill(0);
    text("Generation: ", 30, 40);
    text(gen, 150, 40);
  }
}
