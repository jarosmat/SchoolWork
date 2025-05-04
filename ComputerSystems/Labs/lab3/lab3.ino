#include <funshield.h>

int ids[] = {led1_pin, led2_pin, led3_pin, led4_pin};
int buttonIds[] = {button1_pin, button2_pin, button3_pin};
const int ledNum = 4;
const int timeToElapse = 1000;
void setup() {
  // put your setup code here, to run once:
  for (int i = 0; i < ledNum; ++i){
    pinMode(ids[i], OUTPUT);
    digitalWrite(ids[i], OFF);
  }
  pinMode(button1_pin, INPUT);
}

void offAllLeds(){
  for (int i = 0; i < ledNum; ++i){
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

int isILSBitset(int num, int i){
  return (num & (1 << i));
}

void T1_BitEncoder(int number){
  offAllLeds();
  for (int i = 0;i < ledNum; i++){
    if (isILSBitset(number, i)){
      digitalWrite(ids[i], ON);
    }
  }
}

int num = 0;
void T2_bitCounter(int timeDelay){
  if (timeelapsed(timeDelay)){
    offAllLeds();
    T1_BitEncoder(num);
    num += 1;
  }
}
bool isButtonSet(int buttonId){
  if (digitalRead(buttonId) == LOW){
    return true;
  }
  return false;
}

int T3Num = 0;
void T3_ButtonSetCounter(int button){
  if (isButtonSet(button)){
    T3Num++;
    T1_BitEncoder(T3Num);
  }
}

int buttonLastStat[] = {HIGH, HIGH, HIGH};
bool hasButtonChangedToLow(int buttonId){
  bool toReturn;
  int buttonVal = digitalRead(buttonIds[buttonId]);
  if (buttonLastStat[buttonId] == buttonVal){
    toReturn = false;
  }
  else if (buttonVal == LOW){
    toReturn = true;
  }
  else{
    toReturn = false;
  }
  buttonLastStat[buttonId] = buttonVal;
  return toReturn;
}
int T4num = 0;
void T4_COunter(int buttonId){
  if (hasButtonChangedToLow(buttonId)){
    T4num++;
    T1_BitEncoder(T4num);
  }
}

int T5num = 0;
void T5_COunter(int buttonId, int change){
  if (hasButtonChangedToLow(buttonId)){
    T5num += change;
    T1_BitEncoder(T4num);
  }
}

void loop() {
  //if (timeelapsed(timeToElapse)){
    //T3_ButtonSetCounter(button1_pin);
  //}
  T5_COunter(0, 1);
  T5_COunter(1, -1);
}
