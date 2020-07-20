# Dynamic Response of DC motor to Step Voltage Input.
# 1. State Space.
# using x_dot = [A]x + [B]u, where u is the control input (voltage)
# [A] = [[0,1,0],[0,-b/J,Kt/J],[0,-Kt/L,-Ra/L]]
# [B] = [[0],[0],[1/L]]

# 2. Transfer Function
# 2020.06.01

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

# State Space
J = 0.01
b = 0.001
R = 10
L = 1
A = [[0,1,0],[0,-b/J,1/J],[0,-1/L,-R/L]]
print(A)
x = np.array([[0,0,0]]).T
print(x)
B = np.array([[0,0,1/L]]).T
print(B)
va = 1

deltat = 0.001
tsum = 0
px = []
py1 = []  # py1: angular velocity
py2 = []  # py2: angle
while(tsum < 5):
    x_dot = np.dot(A,x) + np.dot(B,va)
    x = x + np.dot(deltat,x_dot)
    tsum = tsum + deltat
    px.append(tsum)
    py1.append(x[1])
    py2.append(x[0])


#Transfer Function
num = [0,0,100]
den = [1,10.1,101]
sysDC = signal.TransferFunction(num,den)
t1,y1 = signal.step(sysDC)

plt.figure(1)
plt.plot(px,py1,'b--',linewidth=1,label='State Space')
plt.plot(t1,y1,'g:',linewidth=2, label='Transfer Fcn')
plt.legend(loc='best')
plt.show()

