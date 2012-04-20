/*
Timely - The Automator
 Assumes a Pre-created & pre-sorted schedule, stored in schedule[]
 Note that the time to toggle a port is calculated from when the device is switched on.
*/

int tprev = 0, tcur, i, j, k;
int start_port = 3;
int end_port = 13;
int stat[] = {0, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0,  0};//holds port status
int schedule[] = {13, 1000, 13, 2000, 13, 3000, 13, 5000};//port, time : Holds the actual schedule to be run
int sc_size = 8;//size of the schedule array
int loopy[] = {0, sc_size-1, 5};//start, end, repeat_n_times: repeat certain parts of the schedule, n times
int lp_size = 3;//size of the loopy[] array

void toggle(int port) {
  //Toggles the given port
  if(stat[port]==0) {
    stat[port]=1;
    digitalWrite(port, HIGH);
  }
  else {
    stat[port]=0;
    digitalWrite(port, LOW);
  }
}

void setup(){
  //Prepare the device for use:Runs on boot
  for(i = start_port; i <= end_port; i++) {//set ports to output,low
    pinMode(i, OUTPUT);
    digitalWrite(i, LOW);
    stat[i] = 0;
  }
}

void loop() {
  for(j=0; j<lp_size; j=j+3)  {//iterate through the loopy array
    for(k=0; k<loopy[j+2]; k++) {//for each loop section in the loopy array run loopy[j+2] times
      i=loopy[j];
      if(i-1>0)tprev = schedule[i-1];
      else tprev=0;
      while(i<=loopy[j+1]) {//for the schedule[] item sub-set described by loopy[]
        //toggle port & wait
        toggle(schedule[i]);
        tcur = schedule[i+1];
        delay(tcur-tprev);
        tprev = tcur;
        i = i + 2;
      }
    }
  }
}
