# Step response of a 2nd order system, with additional LHP zeros.
# Increase the Overshoot
# Effect is strong when LHP zero is close to poles
# 2020.06.08

from scipy import signal
import matplotlib.pyplot as plt

#Transfer Function
num = [0,0,3]
den = [1,2.8,4]
sys1 = signal.TransferFunction(num,den)
t1,y1 = signal.step(sys1)

num = [0,1.8,3]
den = [1,2.8,4]
sys2 = signal.TransferFunction(num,den)
t2,y2 = signal.step(sys2)

num = [0,0.18,3]
den = [1,2.8,4]
sys3 = signal.TransferFunction(num,den)
t3,y3 = signal.step(sys3)

# plt.plot
plt.plot(t1,y1,label='No zero')
plt.plot(t2,y2,'r--',label='Zero Effect(a*wn=2.4)')
plt.plot(t3,y3,'g--',label='Zero Effect(a*wn=0.24)')
plt.legend(loc='best')
plt.show()

