#include <funshield.h>

void setup() {
  // put your setup code here, to run once:
  pinMode(led1_pin, OUTPUT);
  pinMode(led2_pin, OUTPUT);
  pinMode(led3_pin, OUTPUT);
  pinMode(led4_pin, OUTPUT);
  digitalWrite(led1_pin, OFF);
  digitalWrite(led2_pin, OFF);
  digitalWrite(led3_pin, OFF);
  digitalWrite(led4_pin, OFF);
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
bool val[] = {true, true, true, true};
void change(const int id, int i){
  if (val[i] == true){
    val[i] = false;
    digitalWrite(id, OFF);
  }
  else{
    val[i] = true;
    digitalWrite(id, ON);
  }
}
void changeAll(int ids[], int len){
  for (int j = 0; j < len; ++j){
      change(ids[j], j);
  }
}
void loop() {
  // put your main code here, to run repeatedly:
  int ids[] = {led1_pin, led2_pin, led3_pin, led4_pin};
  if (timeelapsed(250)){
    changeAll(ids, 4);
  }
}
