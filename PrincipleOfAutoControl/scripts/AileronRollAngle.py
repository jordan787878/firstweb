# Feedback Control of Roll Angle with Aileron control input
# Controller: simply adding a gain value: K
# Control Goal: Hold the Roll Angle to 1 degree. (Regulator)
# G(s): The dynamics of Aileron input to Roll angle output
# Control Transfer Fcn: H(s) = KG/(1+KG)
# 2020.06.01

from scipy import signal
import matplotlib.pyplot as plt

k = 100
K = [0.01,0.1,1]
px = [[],[],[]]
py = [[],[],[]]

#Transfer Function
for i in range(3):
    num = [0,0,K[i]*k]
    den = [0.5,1,K[i]*k]
    sys1 = signal.TransferFunction(num,den)
    t1,y1 = signal.step(sys1)
    # plt.plot(t1,y1)
    px[i] = t1
    py[i] = y1
    i = i+1

plt.plot(px[0],py[0],label='Gain=0.01')
plt.plot(px[1],py[1],'r--',label='Gain=0.1')
plt.plot(px[2],py[2],'g:',label='Gain=1')
plt.legend(loc='best')
plt.show()

