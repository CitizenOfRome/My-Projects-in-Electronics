#include "WProgram.h"
void setup();
void loop();
void setup(){
  pinMode(3,OUTPUT);
  pinMode(4,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(6,OUTPUT);
}
void loop(){
  digitalWrite(3,HIGH);
  digitalWrite(4,LOW); 
  digitalWrite(5,HIGH); 
  digitalWrite(6,LOW); 
  delay(2000);
  digitalWrite(3,HIGH);
  digitalWrite(4,LOW); 
  digitalWrite(5,LOW); 
  digitalWrite(6,HIGH); 
  delay(250);
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

