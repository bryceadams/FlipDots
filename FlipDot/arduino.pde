int potentValInt;        // Data received from the serial port
static String potentValString;    // Data received from the serial port

void read_arduino_data() {
  if ( arduinoPort.available() > 0) {  // If data is available,
    potentValString = arduinoPort.readStringUntil('\n'); 
    try {
      potentValInt = Integer.valueOf(potentValString.trim());
    } catch(Exception e) {
      ;
    }
    println(potentValInt); // read it temp
  }  
}
