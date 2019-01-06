class Brain {
  PVector[] gerakan;
  
  int step = 0;
  
  Brain(int maxMove) {
    gerakan = new PVector[maxMove];
    randomize();
  }
  
  void randomize() { // generate random vector directions at the start
    for (int i=0; i<gerakan.length; i++) {
       gerakan[i] = PVector.fromAngle(random(2*PI));
    }
  }
  
  void mutate() { // mutate the babies to introduce variation to the next generation
    float mutationRate = 0.01;
    for (int i=0; i<gerakan.length; i++) {
      float rand = random(1);
      if (rand < mutationRate) gerakan[i] = PVector.fromAngle(random(2*PI));
    }
  }
  
  Brain clone() { // clone brain for new generation
    Brain clone = new Brain(gerakan.length);
    for (int i=0; i<gerakan.length; i++) {
      clone.gerakan[i] = gerakan[i].copy(); 
    }
    return clone;
  }
}
