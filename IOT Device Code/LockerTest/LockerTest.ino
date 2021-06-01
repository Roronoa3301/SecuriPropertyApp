#include <FirebaseESP8266.h>
#include <ESP8266WiFi.h>

#define FIREBASE_HOST "securipropertyapp-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "kcZxkMqCH7konK5rgs4eq1yFWumVupFkoU991whE"
const char *ssid =  "LogueTown_2.4G";     // Enter your WiFi Name
const char *pass =  "GDR@Raftel4034"; // Enter your WiFi Password

const int relay = 5;
FirebaseData fbdo;

String path = "/Rudra/Unlocker";
String Data;

void setup()
{
  Serial.begin(115200);
  delay(10);
  pinMode(relay, OUTPUT);
//  pinMode(12, OUTPUT);
  digitalWrite(relay, HIGH); // keep motor off initally 
  Serial.println("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, pass);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");              // print ... till not connected
  }
  Serial.println("");
  Serial.println("WiFi connected");
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  Serial.print("lock_status: ");
  
  String jsonStr = "";
} 

void printResult(FirebaseData &data)
{
  if (data.dataType() == "string")
  {
    Data = data.stringData();
    Serial.println(data.stringData());
    
  }
  else
  {
    Serial.println(data.payload());
  }
}

void loop()
{
  digitalWrite(relay, HIGH); 
  delay(5000);
  void printResult(FirebaseData &data);
//  Data = fdbo.stringData();
  if(Firebase.get(fbdo, path))
  {
    Serial.println("PASSED");
    Serial.println("PATH: " + fbdo.dataPath());
    Serial.println("TYPE: " + fbdo.dataType());
    Serial.print("VALUE: ");
    if (fbdo.dataType() == "string")
    {
      printResult(fbdo);
      if (Data == "0")
      {
        digitalWrite(relay, LOW);
        Serial.println("Door Unlocked");
//        digitalWrite(12, HIGH);
//        delay(2000);
//        digitalWrite(12, LOW);
      }
      else if (Data == "1")
      {
        digitalWrite(relay, HIGH);
        Serial.println("Door Locked");
//        digitalWrite(12, HIGH);
//        delay(2000);
//        digitalWrite(12, LOW);
      }
      else
      {
        Serial.println("Did not update");
      }
    }

    Serial.println("------------------------------------");
    Serial.println();
  }
  else
  {
    Serial.println("FAILED");
    Serial.println("REASON: " + fbdo.errorReason());
    Serial.println("------------------------------------");
    Serial.println();
  }

  Serial.println("------------------------------------");
  Serial.println("Try to parse return data and get value..");
  delay(10000);
  
}
