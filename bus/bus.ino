#define INTERVAL 100
#define PIN_LED 13
#define PIN_LAMP 3
#define PIN_BUTTON 2

void setup()
{
    pinMode(PIN_LED,OUTPUT);
    pinMode(PIN_LAMP, OUTPUT);
    pinMode(PIN_BUTTON, INPUT);

    Serial.begin(9600);
}

int lamp_state = 0;
void loop()
{
    digitalWrite(PIN_LED, HIGH);
    bool val =  digitalRead(PIN_BUTTON);
    if(Serial.available() > 0){
      int inp = Serial.read();
      if(inp == '1'){
        lamp_state = 1;
      }else if(inp == '0'){
        lamp_state = 0;
      }
    }
    if(lamp_state){
      digitalWrite(PIN_LAMP, HIGH);
      digitalWrite(PIN_LED, HIGH);
    }else{
      digitalWrite(PIN_LAMP, LOW);
      digitalWrite(PIN_LED, LOW);
    }
    if(val){
      Serial.println(0);
    }else{
      Serial.println(1);
    }
    delay(INTERVAL);
}

