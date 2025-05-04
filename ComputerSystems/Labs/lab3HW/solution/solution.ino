#include "funshield.h"

constexpr int ledNum = 4;
constexpr int ids[] = {led4_pin, led3_pin, led2_pin, led1_pin};
constexpr int buttonNum = 3;
constexpr int buttonIds[] = {button1_pin, button2_pin, button3_pin};
constexpr int firstInterval = 1000;
constexpr int secondInterval = 300;
void setup() {
  // put your setup code here, to run once:
  for (int i = 0; i < ledNum; ++i){
    pinMode(ids[i], OUTPUT);
    digitalWrite(ids[i], OFF);
  }
  for (int i = 0; i < buttonNum; i++){
    pinMode(buttonIds[i], INPUT);
  }
}

void offLeds(const int ids[],const int ledNum){
  for (int i = 0; i < ledNum; ++i){
    digitalWrite(ids[i], OFF);
  }
}

//unsigned long lastTime = millis();
bool timeelapsed(unsigned long time, int lastTime) {
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

void encodeBitsToLeds(int number, const int ids[], const int ledNum){
  offLeds(ids, ledNum);
  for (int i = 0;i < ledNum; i++){
    if (isILSBitset(number, i)){
      digitalWrite(ids[i], ON);
    }
  }
}


  bool isButtonSet(int buttonId){
    if (digitalRead(buttonId) == ON){
      return true;
    }
    return false;
  }

unsigned int counter = 0;
void incrementLedsCounter(int increment){
  counter += increment;
}
void setLeds(){
    encodeBitsToLeds(counter, ids, ledNum);
}

unsigned long buttonLastTime[] = {millis(), millis(), millis()};
void updateLastTime(int buttonId){
  buttonLastTime[buttonId] = millis();
}

int buttonIntervals[] = {firstInterval, firstInterval, firstInterval};
int buttonLastStat[] = {OFF, OFF, OFF};

bool isSetToIncrement(int buttonId, int interval, int secondInterval){
  if (buttonLastStat[buttonId] == OFF){
    updateLastTime(buttonId);
    buttonLastStat[buttonId] = ON;
    return true;
  }
  else if (timeelapsed(interval, buttonLastTime[buttonId])){
    updateLastTime(buttonId);
    buttonIntervals[buttonId] = secondInterval;
    return true;
  }
  return false;
}

void handleButtonNotSet(int buttonId, int firstInterval){
  buttonIntervals[buttonId] = firstInterval;
  buttonLastStat[buttonId] = OFF;
}

constexpr int buttonToIncrement = 0;
constexpr int buttonToDecrement = 1;
constexpr int increment = 1;
constexpr int decrement = -1;
void loop() {
  if (isButtonSet(buttonIds[0])){
    if  (isSetToIncrement(buttonToIncrement, buttonIntervals[buttonToIncrement], secondInterval)){
    incrementLedsCounter(increment);
    setLeds();
    }
  }
  else {
    handleButtonNotSet(buttonToIncrement, firstInterval);
  }
  if (isButtonSet(buttonIds[1])){
    if (isSetToIncrement(buttonToDecrement, buttonIntervals[buttonToDecrement], secondInterval)){
    incrementLedsCounter(decrement);
    setLeds();
    }
  }
  else {
    handleButtonNotSet(buttonToDecrement, firstInterval);
  }
}
