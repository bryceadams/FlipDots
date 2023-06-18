#include <Wire.h>
#include "Adafruit_MPR121.h"

#ifndef _BV
#define _BV(bit) (1 << (bit)) 
#endif

// You can have up to 4 on one i2c bus but one is enough for testing!
Adafruit_MPR121 cap = Adafruit_MPR121();

// Keeps track of the last pins touched
// so we know when buttons are 'released'
uint16_t lasttouched = 0;
uint16_t currtouched = 0;


int potA = 0;
int potB = 0;
int potC = 0;

void setup() {
  Serial.begin(9600);
  
  while (!Serial) { // needed to keep leonardo/micro from starting too fast!
    delay(10);
  }
  
  cap.begin(0x5A);
}
 
void loop() {
  int analogValueA = map(analogRead(A0), 0, 1023, 0, 500);
  int analogValueB = map(analogRead(A1), 0, 1023, 0, 500);
  int analogValueC = map(analogRead(A2), 0, 1023, 0, 500);

  if (potA != analogValueA || potB != analogValueB || potC != analogValueC) {
    Serial.print("A:");
    Serial.print(potA);
    
    Serial.print(" B:");
    Serial.print(potB);
    
    Serial.print(" C:");
    Serial.println(potC);
  }

  potA = analogValueA;
  potB = analogValueB;
  potC = analogValueC;

  // capacitive touch stuff
  currtouched = cap.touched();
  
  for (uint8_t i=0; i<12; i++) {
    // it if *is* touched and *wasnt* touched before, alert!
    if ((currtouched & _BV(i)) && !(lasttouched & _BV(i)) ) {
      Serial.print("Touch :");
      Serial.print(i); Serial.println("-1");
    }
    // if it *was* touched and now *isnt*, alert!
    if (!(currtouched & _BV(i)) && (lasttouched & _BV(i)) ) {
      Serial.print("Touch :");
      Serial.print(i); Serial.println("-0");
    }
  }

  // reset our state
  lasttouched = currtouched;
  
  delay(25);
}
