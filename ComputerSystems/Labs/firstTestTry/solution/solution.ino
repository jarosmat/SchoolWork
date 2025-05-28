#include "funshield.h"

constexpr int pinNum = 3;
constexpr int ids[] = {latch_pin, data_pin, clock_pin};

constexpr int numberOfPositions = 4;
unsigned long refreshTime = 300;


constexpr int digits_down_2[10] = { 0xF7, 0xFF, 0xF7, 0xF7, 0xFF, 0xF7, 0xF7, 0xF7, 0xF7, 0xF7 };
constexpr int digits_down[10] = { 0xAB, 0xFB, 0xB3, 0xB3, 0xE3, 0xA7, 0xA7, 0xBB, 0xA3, 0xA3 };
constexpr int digits_up[10] = { 0x9D, 0xFD, 0x9E, 0xBC, 0xFC, 0xBC, 0x9C, 0xFD, 0x9C, 0xBC };
constexpr int digits_up_2[10] = { 0xFE, 0xFF, 0xFE, 0xFE, 0xFF, 0xFE, 0xFE, 0xFF, 0xFE, 0xFE };
const int *digitsShifted[5] = {digits, digits_up, digits_up_2, digits_down, digits_down_2};


unsigned long nthPowerOfX(int x, int n){
      unsigned long result = 1;
      while (n != 0){
        result *= x;
        n -= 1;
      }
      return result;
    }

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
    void reset(){
      position = resetValue;
    }
  private:
    int position;
    int maxPos;
    constexpr static int resetValue = 0;
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
    static unsigned long nthPowerOfX(int x, int n){
      unsigned long result = 1;
      while (n != 0){
        result *= x;
        n -= 1;
      }
      return result;
    }
    void multiplexDisplay(unsigned long value, int position, int digit, bool displayDot){
      if (Display::nthPowerOfX(10, position) <= value || position <= 1){
      byte digitToWrite = digits[digit];
      if (displayDot){
        digitToWrite = digitToWrite & decimalPointMask;
      }
      writeGlyph(digitToWrite, position); 
      }
    }
    void displayDigitsActive(int position, int digit, int stage){
      byte Glyph = digitsShifted[stage][digit];
      if (stage == 2){
        Glyph = Glyph & digitsShifted[4][(digit + 1) % 10];
      }
      writeGlyph(Glyph, position);
    }
  private:
    constexpr static int dataPin = data_pin;
    constexpr static int latchPin = latch_pin;
    constexpr static int clockPin = clock_pin;
    constexpr static int numberOfDigits = 4;
    constexpr static int decimalPointMask = 0x7F;
};


class Timer{
  public:
    unsigned long getTimeSeconds(){
      return (millis() / secondDivider);
    }
  private:
    constexpr static int secondDivider = 1000;
    unsigned long lastTime;
};

class TimeHandler{
  public:
    void init(Timer time){
      timer = time;
    }
    int getDigit(int position){
      long result = timer.getTimeSeconds() / nthPowerOfX(10, position);
      return result % 10;
    }
    int getStage(int position){
      for (int i = 0; i < position; i++){
        if (getDigit(i) != 9){
          return 0;
        }
      }
      return (millis() % 1000) / 250;
    }
  private:
  Timer timer;
};

Display display;
Position position;
Timer timer;
Position stage;
TimeHandler handler;
int increment = 1;

void setup(){
  for (int i = 0; i < pinNum; ++i){
    pinMode(ids[i], OUTPUT);
  }
  position.init(0, numberOfPositions);
  stage.init(0, numberOfPositions);
  handler.init(timer);
}


void loop(){
  int digit = handler.getDigit(position.getPosition());
  int currStage = handler.getStage(position.getPosition());


  display.displayDigitsActive(position.getPosition(), digit, currStage);
  position.incrementPosition(increment);

}

