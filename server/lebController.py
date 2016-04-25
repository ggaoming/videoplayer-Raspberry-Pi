# -*- coding:UTF-8 -*-
import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)
GPIO.setup(11, GPIO.OUT)
GPIO.setup(12, GPIO.OUT)
GPIO.setup(13, GPIO.OUT)
GPIO.setup(15, GPIO.OUT)
GPIO.setup(16, GPIO.OUT)
out_put_keys = [11, 12, 13, 15, 16]

class Controller:
    def __init__(self):
        self.up_out = []
        self.down_out = []
        pass

    def process(self, n, v):
        for i in n:
            print i, v
            GPIO.output(i, v)

    def figure(self, value):
        up_out = []
        down_out = []
        for i in out_put_keys:
            if i in value or int(i) in value:
                up_out.append(i)
            else:
                down_out.append(i)
        self.up_out = up_out
        self.down_out = down_out
        pass

    def close(self):
        self.process(out_put_keys, 0)
        pass

    def run(self, value):

        self.figure(value)
        print 'state ***'
        print ' ', self.up_out
        print ' ', self.down_out
        self.process(self.up_out, 1)
        self.process(self.down_out, 0)
'''
app = Controller()
app.close()
for i in range(1, 10):
    n = i%5
    app.run([out_put_keys[n]])
    time.sleep(1)
app.close()
'''