int potA = 0;

void setup() {
  Serial.begin(9600);
}
 
void loop() {
  int analogValue = map(analogRead(A0), 0, 1023, 0, 500);

  // only change if over 5 difference
  if (abs(potA - analogValue) > 5) {
    potA = analogValue;
  }
  //Serial.write(analogValue);          // send the value serially as a binary value
  Serial.println(potA);
  delay(50);

  // @todo prefix different analog read values when serial print so can read each separately in processing
}
