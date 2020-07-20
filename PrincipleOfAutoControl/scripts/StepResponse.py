import matplotlib.pyplot as plt
from scipy import signal
num = [1]
den = [0.01,0.11,0.1]
sys = signal.TransferFunction(num,den)
t,y = signal.step(sys)

plt.figure(1)
plt.plot(t,y)
plt.title('low pass filter step-response')
plt.grid()

# see bode also
w, mag, phase = signal.bode(sys)
plt.figure(2)
plt.subplot(2,1,1)
plt.semilogx(w, mag)
plt.grid()
plt.subplot(2,1,2)
plt.semilogx(w, phase)
plt.grid()
plt.show()
