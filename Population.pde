class Population {
   Dot[] dots;
   int bestDot=0;
   float fitnessSum, maxStep=2000;
   
   Population(int size) { // initialize population of 'size' dots
     dots = new Dot[size];
     for (int i=0; i<size; i++) {
       dots[i] = new Dot();
     }
   }
   
   void display() {
     for (int i=1; i<dots.length; i++) {
       dots[i].display();
     }
     dots[0].display(); // display the best dot after all other dots is displayed so it is always on top of everything
     fill(0);
     textSize(20);
     text("Best Steps: ", 30, 70);
     text((int)maxStep, 150, 70);
   }
   
   void update() {
     for (int i=0; i<dots.length; i++) {
       if (dots[i].brain.step > maxStep) dots[i].dead = true; // kill the dot if it has exceeded the maxStep
       dots[i].update(); // update dots position
     }
   }
   
   boolean isAllDead() { // check if all dots are dead
     for (int i=0; i<dots.length; i++) {
       if (dots[i].dead == false && dots[i].reachedGoal == false) {
         return false;
       }
     }
       
     return true;
   }
   
   void calculateFitness() { // calculate fitness of all dots in the population after all dots die
     for (int i=0; i<dots.length; i++) {
       dots[i].calculateFitness();
     }
   }
   
   void calculateFitnessSum() { // calculate sum of all dots fitnesses to determine which dot to pick as parent
     fitnessSum = 0;
     for (int i=0; i<dots.length; i++) {
       fitnessSum += dots[i].fitness; 
     }
   }
  
   void naturalSelection() { // begin natural selection algorithm. First find the best dot, then copy the best dot to the new generation without mutating it. For the other, do as described below
     Dot[] newGen = new Dot[dots.length];
     findBestDot();
     calculateFitnessSum();
     
     newGen[0] = dots[bestDot].makeBaby();
     newGen[0].isBest = true;
     for (int i=1; i<dots.length; i++) {
       Dot parent = selectParent(); // find parent dot that we want to make babies from.
       newGen[i] = parent.makeBaby(); // then make population of new dot babies with the parent's brain carbon-cloned.
     }
     
     dots = newGen.clone(); // sets the array of dot population into the new generation set.
     
   }
   
   void findBestDot() { // find best dot
     float max = 0;
     for (int i=0; i<dots.length; i++) {
       if (dots[i].fitness > max) {
         max = dots[i].fitness;
         bestDot = i;
       }
     }
     if (dots[bestDot].reachedGoal) { // if the best dot has reached the goal, set the maxStep to the amount of steps taken by best dot. Next generation of dots shall not exceed the maxStep value.
       maxStep = dots[bestDot].brain.step;
       println("maxStep: ", maxStep);
     }
   }
   
   Dot selectParent() {
     //chooses dot from the population to return randomly(considering fitness)
  
     //this function works by randomly choosing a value between 0 and the sum of all the fitnesses
     //then go through all the dots and add their fitness to a running sum and if that sum is greater than the random value generated that dot is chosen
     //since dots with a higher fitness function add more to the running sum then they have a higher chance of being chosen
     
     float runSum=0;
     float rand = random(fitnessSum);
     
     for (int i=0; i<dots.length; i++) {
       runSum += dots[i].fitness;
       if (runSum > rand) return dots[i];
     }
     
     return null;
   }
   
   void mutate() { // mutate the brain of the new dots to introduce variety to the new generation
     for (int i=1; i<dots.length; i++) {
       dots[i].brain.mutate();
     }
   }
}
