int potentAValInt = 1;        // Data received from the serial port
int potentBValInt = 1;        // Data received from the serial port
int potentCValInt = 1;        // Data received from the serial port
static String potentValString = "1";    // Data received from the serial port
int potentValInt = 100;

void read_arduino_data() {
  if (arduinoPort.available() > 0) {  // If data is available,
    potentValString = arduinoPort.readStringUntil('\n');

    // potentValString is a string like A:500 B:300 C:200 - split by space and convert each number to an INT
    // then assign to the correct variable
    String[] potentVals = split(potentValString, ' ');

    // split each string by a semi colon and assign values
    potentAValInt = Integer.valueOf(split(potentVals[0], ':')[1].trim());
    potentBValInt = Integer.valueOf(split(potentVals[1], ':')[1].trim());

    println(potentVals[2]);
    /*
    potentValString = potentVals[2].readStringUntil('A');
    potentCValInt = Integer.valueOf(split(potentValString, ':')[1].trim());
*/
    print("A: ");
    println(potentAValInt); // read it temp

    print("B: ");
    println(potentBValInt); // read it temp

    //print("C: ");
    //println(potentCValInt); // read it temp
  }  
}
