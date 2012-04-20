char x;
char session[] = {'R', 'C', 'C', 'B', 'C', 'C', 'C', 'L', 'C', 'C'};
int sess_lt = 11;
int class_time = 3000000;//50min
int ring_time = 2000;
int day_ms = 86400000;
int i = 0, j = 1, tym = 0, hflag = 0;
int port = 3;
void setup(){
  pinMode(port,OUTPUT);//bell
  Serial.begin(9600);
}
void interval(int time) {//single point delay element
  delay(time-ring_time);
  tym+=time;
  if(tym >= day_ms) {
    tym = tym-day_ms;
    j++;
  }
  digitalWrite(port, HIGH);
  delay(ring_time);
  digitalWrite(port, LOW);
}
void calle(char cal) {
  switch(cal) {
    case 'R':
      interval(ring_time);
      break;
    case 'C':
      interval(class_time);
      break;
    case 'B':
      interval(300000);//5min
      break;
    case 'L':
      interval(2100000);//35min
      break;
    case 'E':
      interval(day_ms-tym);//rest_of_the_day
      break;
    case 'H':
      interval(day_ms);//24hrs
      break;
  }
}
void loop(){
  //day_ms=86400000 milliseconds/day
  if(j%7==0 || j==13) {//sunday||second_saturday
    calle('H');
    if(j==28)  j=0;
  }
  while(hflag>0) {//holiday
    calle('H');
    hflag--;
  }
  for(i=0; i < sess_lt; i++) {
    if(Serial.available()>0)  {
      x = Serial.read();
      if(x=='H')  hflag++;
      else calle(x);
      i--;
    }
    else  calle(session[i]);
  }
  calle('E');
}
