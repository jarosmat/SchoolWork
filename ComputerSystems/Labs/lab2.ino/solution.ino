int ids[] = {led1_pin, led2_pin, led3_pin, led4_pin};
const int ledNum = 4;
const int timeToElapse = 300;
void setup() {
  // put your setup code here, to run once:
  for (int i = 0; i < ledNum; ++i){
    pinMode(ids[i], OUTPUT);
    digitalWrite(ids[i], OFF);
  }
}
unsigned long lastTime = millis();
bool timeelapsed(unsigned long time) {
  unsigned long ttime = millis();
  if ((ttime - lastTime) >= time){
    lastTime = ttime;
    return true;
  }
  else
  {
    return false;
  }
}
int step = -1;
int curr = 0;
void loop() {
  if (timeelapsed(timeToElapse)){
    if (curr == 3 || curr == 0){
      step = step * (-1);
    }
    digitalWrite(ids[curr], OFF);
    curr += step;
    digitalWrite(ids[curr], ON);
  }
}