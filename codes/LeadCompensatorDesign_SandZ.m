% 2020.06.29 Jordan
% Digital lead compensator design for a second order plant
% Requirement: 
% sample time 0.025 sec, 
% cross over frequency 10 rad/s, 
% phase margin 50 degree
clear;
clc;
%%

% Plant G(s) = 1/s(s+1)
s = tf('s')
G = 1/(s^2+s)
% Find a controller for the unity feedback, discrete-time system, with
% sample time Ts=0.025 sec, with wc = 10 rad/s, PM = 50 degree.
wc = 10
Ts = 0.025

% First, find a continuous controller.
% See bode plot of the plant
figure
bode(G)
title('plant bode plot')
grid on
figure
step(feedback(G,1))
title('plant step response')
grid on
%%
% From bode plot, see a phase angle of -174 degree, at 10 rad/s freqeuncy.
% Thus, 44 degree lead is required
phase_need = 44

% Let's try a Lead Compensator: K = k1*(1+s/a)/(1+s/b)
% By equation: phase_K_max = 2*atan2(sqrt(b/a))-90, sqrt(ab) = wc [degree]
% Get a,b
syms r
eqn = 2*atan2d(r,1)-90 == phase_need
S = solve(eqn,r)
a = round(10/double(S),1)
b = round(wc^2/a,1)
% Get k1
% calculate magnitude of G(wc*i)
x = wc*i
syms X
X = 1/(x^2+x)
mag_G = abs(X)
% calculate magnitude of K (without k1)
X = (1+x/a)/(1+x/b)
mag_K = abs(X)
k1 = 1/mag_G/mag_K
K = k1*(1+s/a)/(1+s/b)

% See the effect of K controller
bode(K*G)
title('KG bode plot')
grid on
%%
% See the step response of the unity feedback control.
sysc = feedback(K*G,1)
figure
step(sysc); hold on
step(feedback(G,1))
legend('with controller K','just unity feedback')
grid on

%%
% Find the discrete Controller Kd.
Kd = c2d(K,Ts,'tustin')
% See how well does Kd work? (Compare it to continuous controller K)
% Must first discrete the plant G
Gd = c2d(G,Ts,'zoh')
% See the step response comparison
sysd = feedback(Kd*Gd,1)
figure
step(sysd); hold on;
step(sysc)
legend('discrete','continuous')
grid on
% See the bode plot comparison
figure
bode(Kd*Gd); hold on;
bode(K*G)
legend('discrete','continuous')
grid on
%%
% Deeper analysis
% See bode plot of G,Gd
figure
subplot(1,2,1)
bode(Gd); hold on;
bode(G);
legend('discrete','continuous')
title('plant bode plot')
grid on
subplot(1,2,2)
bode(Kd); hold on;
bode(K)
legend('discrete','continuous')
title('controller bode plot')
grid on
%%
% From the plant bode plot
% See discrete Gd has a phase lag around 8 degree at wc, 10 rad/s.
% This is because of the zero order hold method used to discretize the
% plant
% In theory, the lag from the zero order hold method is 0.5*w*Ts
phase_lag_zoh = round(0.5*wc*Ts*180/pi,1)
%%
% Redesign the controller, K2d
% Since we (now) understand that the ZOH adds phase lag at crossover, we
% should incorporate that lag from the beginning.
% phase need += phase_lag_zoh.
phase_need = 44 + phase_lag_zoh
% Get a,b
syms r
eqn = 2*atan2d(r,1)-90 == phase_need
S = solve(eqn,r)
a = round(10/double(S),1)
b = round(wc^2/a,1)

% Get k2
% calculate magnitude of G(wc*i)
x = wc*i
syms X
X = 1/(x^2+x)
mag_G = abs(X)
% calculate magnitude of K (without k1)
X = (1+x/a)/(1+x/b)
mag_K = abs(X)
k2 = 1/mag_G/mag_K

% Get Controller K2
K2 = k2*(1+s/a)/(1+s/b)

% See the effect of K2 controller
bode(K2*G); hold on
bode(K*G)
legend('K2*G (redesign)','K*G')
title('K2*G bode plot')
grid on
%%
% Get discrete controller K2d
K2d = c2d(K2,Ts,'tustin')
% See how well does K2d work? (Compare it to continuous controller K, and Kd)
% See the step response comparison
sys2d = feedback(K2d*Gd,1)
figure
step(sysd); hold on;
step(sysc); hold on;
step(sys2d);
legend('discrete','continuous','re-discrete')
title('Step Response - Redesign Discrete Lead Compensator K2d')
grid on









