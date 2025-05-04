#include "funshield.h"

constexpr int ledNum = 3;
constexpr int ids[] = {latch_pin, data_pin, clock_pin};
constexpr int buttonNum = 3;
constexpr int buttonIds[] = {button1_pin, button2_pin, button3_pin};
constexpr int counterInitialValue = 0;
constexpr int counterModValue = 10000;
constexpr int numberOfPositions = 4;

template <typename T, size_t UniqueToken>
class NewType final {
  public:
    NewType() = delete;
    explicit constexpr NewType(T inner) noexcept : value(inner) {}

    inline
    operator T&() noexcept {
        return value;
    }

    constexpr
    operator T() const noexcept {
        return value;
    }

  private:
    // good enough sanity check for single file project, not multifile
    /*
    static_assert(
        UniqueToken > __LINE__,
        "Use the `NEWTYPE` macro to generate newtypes"
    );
    */
    T value;
};

#define NEWTYPE(name, type) using name = NewType<type, __LINE__>;

template <typename T>
class MaybeUninit final {
  public:
    constexpr MaybeUninit() noexcept : m{.uninit = Unit(0)} {}
    constexpr MaybeUninit(T value) noexcept : m{.value = value} {}

    explicit inline
    operator T&() noexcept {
        return m.value;
    }

    inline T&
    assume_init() noexcept {
        return m.value;
    }

  private:
    NEWTYPE(Unit, uint8_t);
    union {
        Unit uninit;
        T value;
    } m;
};


class Button {
  public:
    Button(int buttonId, int value){
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
    Counter(int val, int mod){
      modValue = mod;
      value = val % modValue;
    }
    int nthPowerOfX(int x, int n){
      int result = 1;
      while (n != 0){
        result *= x;
        n -= 1;
      }
      return result;
    }
    void increment(int increment, int digit){
      value = (modValue + value + (nthPowerOfX(10, digit) * increment)) % modValue;
    }
    int getDigit(int digit){
      int result = value / nthPowerOfX(10, digit);
      return result % 10;
    }
    int getValue(){
      return value;
    }
  private:
    int modValue;
    int value;
};

class Display{
  public:
    Display(){
      writeGlyphBitmask(empty_glyph, 0x0F);
    }
    void writeGlyphBitmask(byte glyphMask, byte posMask) {
      digitalWrite(latchPin, LOW);
      shiftOut(dataPin, clockPin, MSBFIRST, glyphMask);
      shiftOut(dataPin, clockPin, MSBFIRST, posMask);
      digitalWrite(latchPin, HIGH);
    }
    void writeGlyph(byte glyph, int pos){
        writeGlyphBitmask(glyph, 1 << (3 - (pos % numberOfDigits)));
    }
    void writeDigit(int digit, int pos){
      writeGlyph(digits[digit], pos % numberOfDigits);
    }
  private:
    constexpr static int dataPin = data_pin;
    constexpr static int latchPin = latch_pin;
    constexpr static int clockPin = clock_pin;
    constexpr static int numberOfDigits = 4;
};
class Position {
  public:
    Position(int pos, int numOfPos){
      position = pos % numOfPos;
      maxPos = numOfPos;
    }
    void incrementPosition(int increment){
      position = (position + increment) % maxPos;
    }
    int getPosition(){
      return position;
    }
  private:
    int position;
    int maxPos;
};

Counter *counter ;
Button *incrementButton;
Button *decrementButton;
Button *rotateButton; 
Display *display;
Position *position;
void setup() {
  for (int i = 0; i < ledNum; ++i){
    pinMode(ids[i], OUTPUT);
  }
  for (int i = 0; i < buttonNum; i++){
    pinMode(buttonIds[i], INPUT);
  }
  counter = new Counter(counterInitialValue, counterModValue);
  incrementButton = new Button(buttonIds[0], OFF);
  decrementButton = new Button(buttonIds[1], OFF);
  rotateButton = new Button(buttonIds[2], OFF); 
  display = new Display();
  position = new Position(0, numberOfPositions);
}

constexpr int increment = 1;
constexpr int decrement = -1;

void loop() {
  //delay(10);
  constexpr int incrementPosition = 0;
  if (incrementButton->wasPressed()){
    counter->increment(increment, incrementPosition);
  }
  if (decrementButton->wasPressed()){
    counter->increment(decrement, incrementPosition);
  }
  position->incrementPosition(increment);
  if (counter->nthPowerOfX(10, position->getPosition()) <= counter->getValue() || position->getPosition() == 0){
  display->writeDigit(counter->getDigit(position->getPosition()), position->getPosition());
  }
}
