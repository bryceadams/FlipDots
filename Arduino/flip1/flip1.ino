int potA = 0;
int potB = 0;
int potC = 0;

void setup() {
  Serial.begin(9600);
}
 
void loop() {
  int analogValue = map(analogRead(A0), 0, 1023, 0, 500);

  // only change if over 5 difference
  if (abs(potA - analogValue) > 5) {
    potA = analogValue;
  }
  Serial.print("A:");
  Serial.print(potA);
  
  int analogValueB = map(analogRead(A1), 0, 1023, 0, 500);

  // only change if over 5 difference
  if (abs(potB - analogValueB) > 5) {
    potB = analogValueB;
  }
  Serial.print(" B:");
  Serial.print(potB);
  
  int analogValueC = map(analogRead(A2), 0, 1023, 0, 500);

  // only change if over 5 difference
  if (abs(potC - analogValueC) > 5) {
    potC = analogValueC;
  }
  Serial.print(" C:");
  Serial.println(potC);
  
  delay(50);
}
