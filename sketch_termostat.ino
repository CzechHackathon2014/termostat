#include <UIPEthernet.h>

#include <OneWire.h>
#include <DallasTemperature.h>

#include <Servo.h> 

Servo myservo;  // create servo object to control a servo 
 
// Data wire is plugged into pin 2 on the Arduino
#define ONE_WIRE_BUS 2
#define TERMOSTAT_ID 100

// Setup a oneWire instance to communicate with any OneWire devices (not just Maxim/Dallas temperature ICs)
OneWire oneWire(ONE_WIRE_BUS);

// Pass our oneWire reference to Dallas Temperature.
DallasTemperature sensors(&oneWire);

EthernetClient client;
signed long next;
int state;

void setup() {
  
  Serial.begin(9600);
  
  sensors.begin();

  uint8_t mac[6] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED};
  Ethernet.begin(mac);
  delay(1000);

  Serial.print("localIP: ");
  Serial.println(Ethernet.localIP());
  Serial.print("subnetMask: ");
  Serial.println(Ethernet.subnetMask());
  Serial.print("gatewayIP: ");
  Serial.println(Ethernet.gatewayIP());
  Serial.print("dnsServerIP: ");
  Serial.println(Ethernet.dnsServerIP());

  state = 0;  
  myservo.attach(6);
}

void loop() {
  
  if (state % 2 == 0) {
  
    sensors.requestTemperatures();
    delay(500);
  
    Serial.println("Send connect");
    
    sendTemperature();

  } else {
      Serial.println("Update connect");
      
      requestTemperatureUpdate();
    
  }
    
    state++;
    delay(1000);
}

void resetEthernet() {
 client.stop();
 delay(1000);
 uint8_t mac[6] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED};
 Ethernet.begin(mac, IPAddress(192,168,2,115));
 delay(1000);
}

void sendTemperature() {
    if (client.connect(IPAddress(192,168,2,116),3000))
    {
      double temp = sensors.getTempCByIndex(0);
	      int length = 17 + countDigits(temp, 2) + 2 + 13 + 3;
    	
      Serial.println("Send connected");
      client.print("POST /submit_temperature HTTP/1.1\r\n");
      client.print("Host: 192.168.2.116\r\n");
      client.print("Content-Length: ");
      client.print(length);
      client.print("\r\n");
      client.print("Connection: close\r\n");
      client.print("Content-Type: application/json\r\n\r\n");
      client.print("{ \"temperature\": ");
      client.print(temp);
      client.print(", \"term_id\": ");
      client.print(TERMOSTAT_ID);
      client.print(" }");
      
      //disconnect client
      Serial.println("Send disconnect");
      client.stop();
    }
    else
    {
      Serial.println("Send connect failed");
      
      resetEthernet();
    }
}

void requestTemperatureUpdate()
{
    if (client.connect(IPAddress(192,168,2,116),3000))
    {    	
      Serial.println("Request connected");
      
      client.println("GET /update_temperature?term_id=100 HTTP/1.1");
      client.println("Host: 192.168.2.116");
      client.println("Connection: close");
      client.println();
      
      delay(1000);
      
      boolean currentLineIsBlank = true;
        
      Serial.println(client.available());
      
      while (client.connected()) {
        while(client.available()) {
        char c = client.read();
  
        // if you've gotten to the end of the line (received a newline
        // character) and the line is blank, the http request has ended,
        // so you can send a reply
        if (c == '\n' && currentLineIsBlank) 
        {
          int bs = client.parseInt();
          int servoPosition = client.parseInt();
          Serial.println(servoPosition);
          if (servoPosition > 19 && servoPosition < 161) {
            moveServo(servoPosition);  
          }
          client.stop();
          break;
        }
  
        if (c == '\n') {
          // you're starting a new line
          currentLineIsBlank = true;
        }
        else if (c != '\r') {
          // you've gotten a character on the current line
          currentLineIsBlank = false;
        }
      }
      }

      //disconnect client
      Serial.println("Send disconnect");
      client.stop();
    }
    else
    {
      Serial.println("Send connect failed");
      
      resetEthernet();
    }    
  
}

void moveServo(int servoPosition) {
    myservo.write(servoPosition);
  
}

// Counts digits of a floating point number, to calculate content length
// for an HTTP call.
// Based on Arduino's internal printFloat() function.
int countDigits(double number, int digits)  { 
  int n = 0;

  // Handle negative numbers
  if (number < 0.0)
  {
    n++; // "-";
    number = -number;
  }

  // Round correctly so that print(1.999, 2) prints as "2.00"
  double rounding = 0.5;
  for (uint8_t i=0; i<digits; ++i) {
    rounding /= 10.0;
  }
  number += rounding;

  // Extract the integer part of the number and print it
  unsigned long int_part = (unsigned long)number;
  double remainder = number - (double)int_part;

  while (int_part > 0) {
    int_part /= 10;
    n++;
  }
  // Print the decimal point, but only if there are digits beyond
  if (digits > 0) {
    n++; //"."; 
  }

  // Extract digits from the remainder one at a time
  while (digits-- > 0)
  {
    remainder *= 10.0;
    int toPrint = int(remainder);
    n ++; // += String(toPrint);
    remainder -= toPrint; 
  } 
  return n;
}

