'''Installation instructions:
    0) This program runs on a Windows system with Speech-API installed
    1) Install EPD-Python 2.7 from http://download.enthought.com/epd_free/epd_free-7.2-2-win-x86.msi
    2) Install distribute by downloading and running http://python-distribute.org/distribute_setup.py 
    3) Install pip by downloading and running https://raw.github.com/pypa/pip/master/contrib/get-pip.py
    4) Install pywin32 from http://sourceforge.net/projects/pywin32/files/pywin32/Build%20217/pywin32-217.win32-py2.7.exe/download
    5) Install pyspeech using pip install speech
    6) Install pyserial using pip install pyserial
    7) Run this file and have fun :)
'''
from threading import Timer, Semaphore
import serial
import datetime
import speech
ser = serial.Serial('COM12', 9600)
sema = Semaphore()
settings = {"off":'0', "on":'1', "toggle":'2'}
ports = {"fan":"13", "three":"03", "3":"03"}
first_nine = {"zero":0, "one":1, "two":2, "three":3, "four":4, "five":5, "six":6, "seven":7, "eight":8, "nine":9}

def evaluate(input):
    '''Evaluate the given input and perform actions; Added as a fix to ayuto-updating sett & port'''
    global ser, settings, sema, ports, first_nine
    words = input.lower().split()
    #on/off/toggle
    try: sett = settings[words[0]]
    except KeyError, IndexError: sett='2'
    #port to use
    try:  port = ports[words[1]]
    except KeyError, IndexError:  port='13'
    def tmp():
      '''Send commands to the uc'''
      sema.acquire()
      ser.write(sett+port)
      print  sett+port, "Command sent at", datetime.datetime.now()
      sema.release()
    #Time to wait before acting
    now = datetime.datetime.now()
    bad_time = False
    time = filter(lambda x: x in first_nine, words[2:])
    if not time or time==[]:  bad_time = True
    if bad_time or time[0]=="now":
      delay = 0
    else:
      time = [x if x in first_nine else "zero" for x in time]
      tlen = len(time)
      if tlen<6: time += ["zero"]*(6-tlen)
      time = map(lambda s: str(first_nine[s]), time)
      hrdel = int("".join(time[:2])) - now.hour
      mndel = int("".join(time[2:4])) - now.minute
      scdel = int("".join(time[4:6])) - now.second
      if hrdel<0: hrdel+=24
      if mndel<0: mndel+=60
      if scdel<0: scdel+=60
      delay = 3600*hrdel + 60*mndel + scdel
    print delay
    #Create a thread to execute action at given time
    Timer(delay, tmp).start()

while True:

    try:
        print "Please say the command out loud or press Ctrl+C twice to exit"
        speech.say("Please say the command out loud")
        input = speech.input("Please press Control plus C to type the command instead.") #"on fan zero nine three eight"
        print input,
        while speech.islistening():
            delta = speech.input(" - ")
            input += delta
            print delta,
        speech.say("You said: "+input)
        print ""
    except KeyboardInterrupt:
        speech.stoplistening()
        print ("Please type your command here; Press Ctrl+C to exit")
        try: input = raw_input()
        except KeyboardInterrupt: break

    if input!="": evaluate(input)
    input = ""

