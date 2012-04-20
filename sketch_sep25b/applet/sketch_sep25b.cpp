#include "WProgram.h"
void setup();
void goFd();
void goLt();
void loop();
void setup(){
  pinMode(3,OUTPUT);
  pinMode(4,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(6,OUTPUT);
}
void goFd() {
  digitalWrite(3,HIGH);
  digitalWrite(4,LOW);
  digitalWrite(5,HIGH);
  digitalWrite(6,LOW);
}

void goLt() {
  digitalWrite(3,HIGH);
  digitalWrite(4,LOW);
  digitalWrite(5,LOW);
  digitalWrite(6,HIGH);
}
void loop(){
  goFd();
  delay(1000);
  goLt();
  delay(256);
  goFd();
  delay(1000);
  goLt();
  delay(256);
  goFd();
  delay(1000);
  goLt();
  delay(256);
  goFd();
  delay(1000);
  goLt();
  delay(256);
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

