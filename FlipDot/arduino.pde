int potentAValInt = 1;        // Data received from the serial port
int potentBValInt = 1;        // Data received from the serial port
int potentCValInt = 1;        // Data received from the serial port
static String potentValString = "1";    // Data received from the serial port

void read_arduino_data() {
  if (arduinoPort.available() > 0) {  // If data is available,
    potentValString = arduinoPort.readStringUntil('\n');

    // potentValString is a string like A:500 B:300 C:200 - split by space and convert each number to an INT
    // then assign to the correct variable
    String[] potentVals = split(potentValString, ' ');

    // only continue if starts with A:
    // split each string by a semi colon and assign values
    if (potentVals != null && potentVals[0].startsWith("A:") && potentVals.length >= 2) {
      // add error catching here in case this fails
      try {
        potentAValInt = Integer.valueOf(split(potentVals[0], ':')[1].trim());
        potentBValInt = Integer.valueOf(split(potentVals[1], ':')[1].trim());
        potentCValInt = Integer.valueOf(split(potentVals[2], ':')[1].trim());
      }
      catch (Exception e) {
        //println("Error parsing data from Arduino");
      }
    }
  }  
}