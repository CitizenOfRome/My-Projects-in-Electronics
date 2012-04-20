/*
Timely - The Automator
 Sorted dB (insert accurately): time-from-zero, port => trigger event when 'tis time(as calc from delays)
 Linked list to implement the above, funcs: add, remove
 add : 
*/
typedef struct node {
   int port;
   int time;
   struct node * next;
   struct node * prev;
} node;
node* start = (node*) malloc(sizeof(node)), *item, *temp=start;
int tprev = 0, tcur;
int stat[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

void setup(){
  //create ll
  start->port=start->time=NULL;
  start->next=NULL;
  start->prev=NULL;
   
}

void add(int port, int time) {
  ///put in ll : go frm start, cmp
  temp = start;
  if(temp->port==NULL) {
    temp->port = port;
    temp->time = time;
    temp->next = temp->prev = NULL;
    return;
  }
  while(temp->next!=NULL && (temp->next)->time <= time) {
    temp=temp->next;
  }
  item = (node*) malloc(sizeof(node));
  item->port = port;
  item->time = time;
  item->prev = temp;
  item->next = temp->next;
  if(temp->next!=NULL)  (temp->next)->prev = item;
  temp->next = item;
}

void del(int port, int time) {
  temp = start;
  while(!(temp->port==port && temp->time==time)) {
     temp = temp->next; 
  }
  (temp->prev)->next = temp->next;
  (temp->next)->prev = temp->prev;
  temp=NULL;
}

void toggle(int port) {
  if(stat[port]==0) {
    stat[port]=1;
    digitalWrite(port, HIGH);
  }
  else {
    stat[port]=0;
    digitalWrite(port, LOW);
  }
}

void loop() {
  //process ll, tcur-tprev=delay
  temp=start;
  while(temp!=NULL) {
    //toggle & wait
    toggle(temp->port);
    tcur = temp->time;
    delay(tcur-tprev);
    tprev = tcur;
  }
}
