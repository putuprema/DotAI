class Dot {
  PVector pos; // position
  PVector vel; // velocity
  PVector accel; // acceleration
  Brain brain; // add brain of each dot object
  
  boolean dead=false, reachedGoal=false, isBest=false;
  float fitness=0;
  
  Dot() { 
    brain = new Brain(2000); // add brain of each dot object and set max movement to 2000
    pos = new PVector(width/2,height-10);
    vel = new PVector(0,0);
    accel = new PVector(0,0);
  }
  
  void move() {
    if (brain.gerakan.length > brain.step) { // kill the dot if the dot has ran out of steps (max brain steps is 2000)
      accel = brain.gerakan[brain.step];
      brain.step++;
    } else {
      dead = true;
    }
    
    if (pos.x >= width-1 || pos.x <= 1 || pos.y >= height-1 || pos.y <= 1) { // kill the dot when exceeding the window boundary
      dead = true;
    }
    
    //if (pos.x <= 640 && pos.x >= 200 && pos.y <= 135 && pos.y >= 115) dead = true; // kill the dot when touching the obstacle boundary 2
    //if (pos.x <= 500 && pos.x >= 20 && pos.y <= height/2+65 && pos.y >= height/2+47) dead = true; // kill the dot when touching the obstacle boundary 1
    
    vel.add(accel); // increase velocity and change its direction with vector addition function
    vel.limit(3); // limit the velocity magnitude to 3
    pos.add(vel); // change the position vector based on velocity
  }
  
  void update() {
    if (!dead && !reachedGoal) move(); // don't move (kill) the dot if it is dead or has reached the goal
    
    if (dist(pos.x,pos.y,goal.x,goal.y) < 5) { // considered the goal is reached when distance between the dot and the goal is less than 5
      reachedGoal = true;
    }
  }
  
  void display() {
    if (isBest) { // display the best dot as green dot, otherwise black
      fill(0,255,0);
      ellipse(pos.x,pos.y,8,8); 
    } else {
      fill(0);
      ellipse(pos.x,pos.y,4,4);       
    }
  }
  
  void calculateFitness() { // calculate fitness of each dot to determine the parent needed to make babies.
    if (reachedGoal) {
      fitness = 1 - ((float)(brain.step)/1000);
      //println(fitness,brain.step);
    } else {
      float distanceToGoal = dist(pos.x,pos.y,goal.x,goal.y);
      fitness = 1.0/(distanceToGoal*distanceToGoal);
      //println("fitness is ", fitness);
    }
  }
  
  Dot makeBaby() { // make babies with the brains from previous generation carbon-cloned to them.
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby;
  }
}
