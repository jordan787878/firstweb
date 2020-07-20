# PID control of a 2nd order system, G = [0,0,1]/[1,1,1]
#-------------------------------------------------------------
# 2020.06.08

from scipy import signal
import matplotlib.pyplot as plt

#Transfer Function
num = [0,0,1]
den = [1,1,1]
sysG = signal.TransferFunction(num,den)
tG,yG = signal.step(sysG)

num = [0,0,3]
den = [1,1,4]
sys0 = signal.TransferFunction(num,den)
t0,y0 = signal.step(sys0)

num = [0,0,3]
den = [1,2.8,4]
sys1 = signal.TransferFunction(num,den)
t1,y1 = signal.step(sys1)

num = [0,0,3,1.2]
den = [1,2.8,4,1.2]
sys2 = signal.TransferFunction(num,den)
t2,y2 = signal.step(sys2)

# plt.plot
plt.plot(tG,yG,label='Plant Response(No control)')
plt.plot(t0,y0,label='P control, Kp=2')
plt.plot(t1,y1,label='PD control, Kp=3, KD=1.8')
plt.plot(t2,y2,label='PID control, Kp=3, KD=1.8, Ki=1.2')
plt.legend(loc='best')
plt.show()


