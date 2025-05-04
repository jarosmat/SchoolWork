#include "funshield.h"

constexpr int ledNum = 7;
constexpr int ids[] = {led4_pin, led3_pin, led2_pin, led1_pin, latch_pin, data_pin, clock_pin};
constexpr int buttonNum = 3;
constexpr int buttonIds[] = {button1_pin, button2_pin, button3_pin};
constexpr int firstInterval = 1000;
constexpr int secondInterval = 300;
byte characterToDisplay[] = {
        B00001000,  //  A
        B00000011,  //  B
        B01000110,  //  C
        B00100001,  //  D
        B00000110,  //  E
        B00001110,  //  F
        B01000010,  //  G
        B00001011,  //  H
        B01001111,  //  I
        B01100001,  //  J
        B00001010,  //  K
        B01000111,  //  L
        B01101010,  //  M
        B01001000,  //  N
        B01000000,  //  O
        B00001100,  //  P
        B00011000,  //  Q
        B01001100,  //  R
        B00010010,  //  S
        B00000111,  //  T
        B01000001,  //  U
        B01010001,  //  V
        B01010101,  //  W
        B00001001,  //  X
        B00010001,  //  Y
        B00110100,  //  Z
    };
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

void setup() {
  // put your setup code here, to run once:
  for (int i = 0; i < ledNum; ++i){
    pinMode(ids[i], OUTPUT);
    digitalWrite(ids[i], OFF);
  }
  for (int i = 0; i < buttonNum; i++){
    pinMode(buttonIds[i], INPUT);
  }
  Serial.begin(9600);
    write_glyph_bitmask(empty_glyph, 0x0F);
}
void write_glyph_bitmask(byte glyph_mask, byte pos_mask) {
digitalWrite(latch_pin, LOW);
shiftOut(data_pin, clock_pin, MSBFIRST, glyph_mask);
shiftOut(data_pin, clock_pin, MSBFIRST, pos_mask);
digitalWrite(latch_pin, HIGH);
}
void write_glyph(byte glyph, int pos, char side){
  if (side == 'L'){
    write_glyph_bitmask(glyph, 1 << pos);
  }
  else if (side == 'R'){
    write_glyph_bitmask(glyph, 1 << (3 - pos));
  }
}
void write_digit(int digit, int pos, char side){
  write_glyph(digits[digit], pos, side);
}
int word_num = 0;
int counterDisplay = 0;
void displayRight(){
  write_digit(counterDisplay, 3, 'L');
  counterDisplay += 1;
  counterDisplay %= 10;
}
void loop() {
  if (timeelapsed(1000)){
    displayRight();
    word_num %= 26;
    word_num += 1;    
    write_glyph(characterToDisplay[word_num], 0, 'L');
  }
}

