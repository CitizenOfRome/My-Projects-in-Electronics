char x;
void setup(){
  pinMode(3,OUTPUT);
  pinMode(4,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(6,OUTPUT);
  Serial.begin(9600);
}
void goFd() {
  digitalWrite(3,HIGH);
  digitalWrite(4,LOW);
  digitalWrite(5,HIGH);
  digitalWrite(6,LOW);
}
void goBk() {
  digitalWrite(3,LOW);
  digitalWrite(4,HIGH);
  digitalWrite(5,LOW);
  digitalWrite(6,HIGH);
}
void goLt() {
  digitalWrite(3,HIGH);
  digitalWrite(4,LOW);
  digitalWrite(5,LOW);
  digitalWrite(6,HIGH);
}
void goRt() {
  digitalWrite(3,LOW);
  digitalWrite(4,HIGH);
  digitalWrite(5,HIGH);
  digitalWrite(6,LOW);
}
void stp() {
  digitalWrite(3,LOW);
  digitalWrite(4,LOW);
  digitalWrite(5,LOW);
  digitalWrite(6,LOW);
}
void loop(){
  if(Serial.available()>0)  {
    x = Serial.read();
    if(x=='w') {
      goFd();
      delay(200);
      stp();
    }
    else if(x=='s') {
      goBk();
      delay(200);
      stp();
    }
    else if(x=='a') {
      goLt();
      delay(200);
      stp();
    }
    else if(x=='d') {
      goRt();
      delay(200);
      stp();
    }
    else {
      stp();
      delay(200);
    }
  }
}  
