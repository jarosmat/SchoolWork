#include "input.h"
#include "funshield.h"


constexpr int pinNum = 3;
constexpr int ids[] = {latch_pin, data_pin, clock_pin};
constexpr int buttonNum = 3;
constexpr int buttonIds[] = {button1_pin, button2_pin, button3_pin};

constexpr int counterInitialValue = 0;
constexpr long counterModValue = 1000000;
constexpr int numberOfPositions = 4;
constexpr int stopwatchOrderShift = 2;


enum Letters {
  A = 0,
  B,
  C,
  D,
  E,
  F,
  G,
  H,
  I,
  J,
  K,
  L,
  M,
  N,
  O,
  P,
  Q,
  R,
  S,
  T,
  U,
  V,
  W,
  X,
  Y,
  Z
};

constexpr byte LETTER_GLYPH[] {
  0b10001000,   // A
  0b10000011,   // b
  0b11000110,   // C
  0b10100001,   // d
  0b10000110,   // E
  0b10001110,   // F
  0b10000010,   // G
  0b10001001,   // H
  0b11111001,   // I
  0b11100001,   // J
  0b10000101,   // K
  0b11000111,   // L
  0b11001000,   // M
  0b10101011,   // n
  0b10100011,   // o
  0b10001100,   // P
  0b10011000,   // q
  0b10101111,   // r
  0b10010010,   // S
  0b10000111,   // t
  0b11000001,   // U
  0b11100011,   // v
  0b10000001,   // W
  0b10110110,   // ksi
  0b10010001,   // Y
  0b10100100,   // Z
};
constexpr byte EMPTY_GLYPH = 0b11111111;

constexpr int positionsCount = 4;
constexpr unsigned int scrollingInterval = 300;


/** 
 * Convert a chararcter to a glyph. If character is not letter, empty glyph is displayed instead.
 * @param ch character to be displayed
 * return value: a glyph to be displayed using time multiplex
 * hint: use/extend your class (or functions) for multiplexind the display developed in previous labs
 */

byte charToGlyph(char ch)
{
  byte glyph = EMPTY_GLYPH;
  if (isAlpha(ch)) {
    glyph = LETTER_GLYPH[ ch - (isUpperCase(ch) ? 'A' : 'a') ];
  }
  // similarly, you can extend this function for digits
  // if (isDigit(ch))
  //   glyph = ....[ ch - '0' ];
  // ....

  return glyph;
}


class Button {
  public:
    void init(int buttonId, int value){
      id = buttonId;
      lastValue = value;
    }
    bool isButtonSet(int buttonId){
      return digitalRead(buttonId) == ON;
    }
    int getId(){
      return id;
    }
    int getLastValue(){
      return lastValue;
    }
    void setLastValue(int value){
      lastValue = value;
    }
    bool wasPressed(){
      if (!isButtonSet(id)){
        lastValue = OFF;
        return false;
      }
      else if (lastValue == ON){
        return false;
      }
      else {
        lastValue = ON;
        return true;
      }
    }
  private:
    int id;
    int lastValue;
};

class Counter {
  public:
    Counter(){

    }
    void init(long val, long mod){
      modValue = mod;
      value = val % modValue;
    }

    static unsigned long nthPowerOfX(int x, int n){
      unsigned long result = 1;
      while (n != 0){
        result *= x;
        n -= 1;
      }
      return result;
    }

    void increment(long increment, int digit){
      long toAdd = value + (nthPowerOfX(10, digit) * increment);
      if (toAdd < 0){
        toAdd += modValue;
      }
      value = toAdd % modValue;
    }

    int getDigit(int digit){
      long result = value / nthPowerOfX(10, digit);

      return result % 10;
    }

    long getValue(){
      return value % modValue;
    }

    void setValue(long val){
      value = val % modValue;
    }
  private:
    long modValue;
    long value;
};

class Position {
  public:
    void init(int pos, int numOfPos){
      position = pos % numOfPos;
      maxPos = numOfPos;
    }
    void incrementPosition(int increment){
      position = (maxPos + position + increment) % maxPos;
    }
    int getPosition(){
      return position;
    }
  private:
    int position;
    int maxPos;
};

class Display{
  public:
    void init(){
      writeGlyphBitmask(empty_glyph, 0x0F);
    }
    void writeGlyphBitmask(byte glyphMask, byte posMask) {
      digitalWrite(latchPin, LOW);
      shiftOut(dataPin, clockPin, MSBFIRST, glyphMask);
      shiftOut(dataPin, clockPin, MSBFIRST, posMask);
      digitalWrite(latchPin, HIGH);
    }
    void writeGlyph(byte glyph, int pos){
        writeGlyphBitmask(glyph, 1 << ((numberOfDigits - 1) - (pos % numberOfDigits)));
    }
    void writeGLyphRight(byte glyph, int pos){
      writeGlyphBitmask(glyph, 1 << (pos % numberOfDigits));
    }
    void writeDigit(int digit, int pos){
      writeGlyph(digits[digit], pos % numberOfDigits);
    }
    void multiplexDisplay(unsigned long value, int position, int digit, bool displayDot){
      if (Counter::nthPowerOfX(10, position) <= value || position <= 1){
      byte digitToWrite = digits[digit];
      if (displayDot){
        digitToWrite = digitToWrite & decimalPointMask;
      }
      writeGlyph(digitToWrite, position); 
      }
    }
    void set(const char * msg, int position){
      const char toWrite = msg[position % numberOfDigits];
      writeGLyphRight(charToGlyph(toWrite), position);
    }
  private:
    constexpr static int dataPin = data_pin;
    constexpr static int latchPin = latch_pin;
    constexpr static int clockPin = clock_pin;
    constexpr static int numberOfDigits = 4;
    constexpr static int decimalPointMask = 0x7F;
};

class Stopwatch{
  public:
    Stopwatch(){}
    void init(long maxValue){
      counter.init(startVal, maxValue);
    }
    void updateTime(){
      counter.increment(millis() - lastTime, digitToIncrement);
      startTime();
    }
    unsigned long getTimeMiliseconds(unsigned long divideBy){
      return counter.getValue() / divideBy;
    }
    void resetStopwatch(){
      counter.setValue(startVal);
    }
    int getDigit(int digit){
      return counter.getDigit(digit);
    }
    void startTime(){
      lastTime = millis();
    }
  private:
    Counter counter;
    static constexpr long startVal = 0;
    static constexpr int digitToIncrement = 0;
    unsigned long lastTime;
};

enum States {
  STOPPED,
  RUNNING,
  LAPPED,
};

class StopwatchHandler{
  public:
    void init(Stopwatch clock, int stopwatchOrderShift){
      stopwatch = clock;
      toDivideBy = Counter::nthPowerOfX(10, stopwatchOrderShift);
      orderShift = stopwatchOrderShift;
    }
    void StartStopStopwatch(){
      if (state == STOPPED){
        state = RUNNING;
        stopwatch.startTime();
      }
      else if (state == RUNNING){
        state = STOPPED;
      }
    }
    void SplitResumeStopwatch(){
      if (state == RUNNING){
        state = LAPPED;
      }
      else if (state == LAPPED){
        state = RUNNING;
      }
    }
    void ResetStopwatch(){
      if (state == STOPPED){
        stopwatch.resetStopwatch();
      }
    }
    void UpdateTime(){
      stopwatch.updateTime();
    }
    enum States getState(){
      return state;
    }

    int getDigit(int digit){
      return stopwatch.getDigit(digit + orderShift);
      //return (getTimeToDisplay()/ Counter::nthPowerOfX(10, digit))% 10;
    }

    unsigned long getTimeToDisplay(){
      return stopwatch.getTimeMiliseconds(toDivideBy);
    }
  private:
  enum States state = STOPPED;
  Stopwatch stopwatch;
  unsigned long toDivideBy;
  int orderShift = 0;
};

Button startStopButton;
Button splitResumeButton;
Button resetButton; 
Display display;
Position position;
Position startPosition;
Stopwatch stopwatch;
StopwatchHandler handler;

constexpr int increment = 1;
constexpr int decimalPoint = 1;

void setup() {
  for (int i = 0; i < pinNum; ++i){
    pinMode(ids[i], OUTPUT);
  }
  for (int i = 0; i < buttonNum; i++){
    pinMode(buttonIds[i], INPUT);
  }
  startStopButton.init(buttonIds[0], OFF);
  splitResumeButton.init(buttonIds[1], OFF);
  resetButton.init(buttonIds[2], OFF);
  position.init(0, numberOfPositions);
  stopwatch.init(counterModValue);
  handler.init(stopwatch, stopwatchOrderShift);
  startPosition.init(0, numberOfPositions);
}

void loop() {
  /*if (handler.getState() == RUNNING){
    handler.UpdateTime();
  }
  if (startStopButton.wasPressed()){
    handler.StartStopStopwatch();
  }
  if (splitResumeButton.wasPressed()){
    handler.SplitResumeStopwatch();
  }
  if (resetButton.wasPressed()){
    handler.ResetStopwatch();
  }
  display.multiplexDisplay(handler.getTimeToDisplay(), position.getPosition(), handler.getDigit(position.getPosition()), position.getPosition() == decimalPoint);
  */
  const char * xd = "lodaspdoasodasp";
  display.set(xd, position.getPosition());
  position.incrementPosition(increment);
}
