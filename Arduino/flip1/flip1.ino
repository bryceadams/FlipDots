void setup() {
  Serial.begin(9600);
}
 
void loop() {
  int analogValue = map(analogRead(A0), 0, 1023, 0, 500);
  //Serial.write(analogValue);          // send the value serially as a binary value
  Serial.println(analogValue);
  delay(50);

  // @todo prefix different analog read values when serial print so can read each separately in processing
}
