# 2020.07.20 Chun-Wei, Kong
# Figure 1 shows the Interference of dipole
# Figure 2 shows the diffration (multiple source interference), where the each wavelength corresponds to different color of visible light.

import numpy as np
import matplotlib.pyplot as plt
import math

A1 = 1
A2 = 1

# 1 in the South; 2 in the North
# +a: y1 lags y2 by a
# -a: y1 leads y2 by a
a = 0
ph1 = 0
ph2 = a

# dist_ratio : d/lambda ratio.
# a: intrinsic time phase. (set above)
def result_energy(dist_ratio):
    deltaph = [a + 2*math.pi*dist_ratio*math.sin(i) for i in theta]
    return np.array([A1*A1 + A2*A2 + 2*A1*A2*math.cos(i) for i in deltaph])

# dist_ratio: d/lambda ratio
# n: number of sources
# theta: angular position.
def result_I(dist_ratio,n,theta):
    c1 = math.pi * dist_ratio * n
    c2 = math.pi * dist_ratio
    num = np.array([pow( math.sin(c1 * math.sin(i)),2 ) for i in theta])
    den = np.array([pow( math.sin(c2 * math.sin(i)),2 ) for i in theta])
    I = np.zeros(len(num))

    for i in range(len(num)):
        if(num[i] < abs(1.0E-15)):
            if i == 0:
                I[i] = num[i+1]/den[i+1]
                print(theta[i])
            elif i == len(I)-1:
                I[i] = num[i-1]/den[i-1]
                print(theta[i])
            else:
                I[i] = 0.5*(num[i-1]/den[i-1] + num[i+1]/den[i+1])
                print(theta[i])
        else:
            I[i] = num[i]/den[i]        
    
    return I


theta = np.arange(0*math.pi/180,180*math.pi/180,0.01*math.pi/180)

# Superposition of resultant wave Ar
Ar1 = result_energy(1)
#Ar2 = result_energy(6)
#Ar3 = result_energy(2)
#Ar = Ar1+Ar2+Ar3

plt.figure(1)
plt.plot(180*theta/math.pi,Ar1)
plt.title('Interference')
plt.xlabel('degree')
plt.ylabel('Energy Intensity')
#plt.show()

# Diffraction
n = 20
dist_ratio1 = 1.613 
I1 = result_I(dist_ratio1,n,theta)

dist_ratio2 = 1.754
I2 = result_I(dist_ratio2,n,theta)

dist_ratio3 = 2.632 
I3 = result_I(dist_ratio3,n,theta)

dist_ratio4 = 2.020
I4 = result_I(dist_ratio4,n,theta)



plt.figure(2)
plt.plot(theta,I1,'r',label=str(dist_ratio1))
plt.plot(theta,I2,'y',label=str(dist_ratio2))
plt.plot(theta,I3,'b',label=str(dist_ratio3))
plt.plot(theta,I4,'g',label=str(dist_ratio3))
plt.legend(loc='best')
plt.title('Diffration')
plt.xlabel('theta (rad)')
plt.ylabel('Intensity')
plt.grid()
plt.show()

