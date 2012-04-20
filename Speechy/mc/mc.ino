int sett, port_tens, port_units, port;
int i, start_port=2, end_port=13;
int stat[] = {0, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0,  0,0};//holds port status
int input[3], index=0, tmp;
void on(int port) {
  //Sets the given port to HIGH
  stat[port]=1;
  digitalWrite(port, HIGH);
}
void off(int port) {
  //Sets the given port to LOW
  stat[port]=0;
  digitalWrite(port, LOW);
}
void toggle(int port) {
  //Toggles the given port
  if(stat[port]==0)  on(port);
  else  off(port);
}

void setup(){
  //Prepare the device for use:Runs on boot
  for(i = start_port; i <= end_port; i++) {//set ports to output,low
    pinMode(i, OUTPUT);
    digitalWrite(i, LOW);
    stat[i] = 0;
  }
  Serial.begin(9600);
}

void loop(){
  if(Serial.available()) { 
    delay(100);
    while (Serial.available()) { 
      tmp = Serial.read();
      tmp = tmp - '0';      
      input[index] = tmp;
      index++;
    }
    index = 0;
    sett = input[0];
    port = input[1]*10 + input[2]; //The port to be controlled
    if(port<3 || port>13) port=13;
    switch(sett) {
        case 0:
            off(port);
            break;
        case 1:
            on(port);
            break;
        case 2:
            toggle(port);
            break;
    }
  }
}
