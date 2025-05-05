#include "input.h"
#include "funshield.h"


constexpr int pinNum = 3;
constexpr int ids[] = {latch_pin, data_pin, clock_pin};

constexpr int numberOfPositions = 4;
unsigned long refreshTime = 300;


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

byte charToGlyph(char ch)
{
  byte glyph = EMPTY_GLYPH;
  if (isAlpha(ch)) {
    glyph = LETTER_GLYPH[ ch - (isUpperCase(ch) ? 'A' : 'a') ];
  }
  return glyph;
}

class Timer{
  public:
  void init(){
    lastTime = millis();
  }
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
  private:
    unsigned long lastTime;
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
    void set(char msg, int position){
      writeGLyphRight(charToGlyph(msg), position);
    }
  private:
    constexpr static int dataPin = data_pin;
    constexpr static int latchPin = latch_pin;
    constexpr static int clockPin = clock_pin;
    constexpr static int numberOfDigits = 4;
    constexpr static int decimalPointMask = 0x7F;
};


class MessageHandler{
  public:
    void init(const char * mess, int winLen){
      message = mess;
      message -= winLen;
      startOffset = windowLenght;
    }
    void shiftWindow(int shift){
      message += shift;
      if (startOffset != 0){
        startOffset--;
      }
    }
    bool isCompleted(){
      return message[startOffset] == stringEnd;
    }
    bool indexIsEnd(int index){
      return index >= startOffset && message[index] == stringEnd;
    }
    char getChar(int offset){
      return message[offset];
    }
    void SetMessage(const char * mess){
      message = mess;
      message -= windowLenght;
      startOffset = windowLenght;
    }
  private:
    const char stringEnd = '\0';
    const char * message;
    constexpr static int windowLenght = 4;
    int startOffset = windowLenght;
};
 
Display display;
Position position;
Timer timer;
SerialInputHandler inputHandler;
MessageHandler messageHandler;

constexpr int increment = 1;

void setup() {
  for (int i = 0; i < pinNum; ++i){
    pinMode(ids[i], OUTPUT);
  }
  position.init(0, numberOfPositions);
  timer.init();
  inputHandler.initialize();
  messageHandler.init(inputHandler.getMessage(),numberOfPositions);
}

void loop() {
  inputHandler.updateInLoop();
  if (timer.timeelapsed(refreshTime)){ 
    messageHandler.shiftWindow(increment);
    if (messageHandler.isCompleted()){
      messageHandler.SetMessage(inputHandler.getMessage());
    }
  }
  if (messageHandler.indexIsEnd(position.getPosition())){
    position.reset();
  }
  else{
    display.set(messageHandler.getChar(position.getPosition()), position.getPosition());
    position.incrementPosition(increment);
  }
}
