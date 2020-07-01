class FuelGauge {

  void show() {
    textSize(20);
    int textPosX = width/2 - 150;
    int tank = int(ldr.fuel);
    if (tank >= 1775) {
      fill(0, 255, 0);
    } else if (tank < 1775 && tank > 650) {
      fill(255, 255, 0);
    } else if (tank < 650) {
      fill(255, 0, 0);
    }
    text("FUEL", width/2 - textWidth("FUEL")/2, 30);
    
    // fuel amount
    strokeWeight(10);
    stroke(255, 0, 0);
    line(textPosX, 50, textPosX+40, 50); // red band
    stroke(255, 255, 0);
    line(textPosX+40, 50, textPosX+110, 50); // yellow band
    stroke(0, 255, 0);
    line(textPosX+110, 50, textPosX+302, 50); // green band
    
    // fuel needle
    float needlepos = map(ldr.fuel, 0, 5000, textPosX, textPosX+301);
    stroke(255);
    strokeWeight(3);
    line(needlepos, 40, needlepos, 60);
  }
}