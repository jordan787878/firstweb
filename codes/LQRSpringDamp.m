% 2020.07.05 JORDAN
% LQR method, spring-damp-mass system
% See the initial response of different set of [Q] and [R]
% The code display Force_effort, and Steady State Time.
% And shows the commanded force input; u(t) = r-[K]x
% mass = 1kg, r = 0

clc;
clear;
close all
%%

% Initial Conditions
x0 = [3;  % 3 m
      0]; % 0 m/s

% System Dynamics
k = 1
b = 0.4


A = [0    1; 
     -k -b];
B = [0; 
     1];
C = [1 0];
D = 0;

sys_p = ss(A,B,C,D)
t = 0:0.005:30;
%figure
%initial(sys_p, x0, t)
%
Q = [1 0;  % Penalize position error
     0 1]; % Penalize velociry error
R = 0.1;     % Penalize force effort
K = lqr(A,B,Q,R);

% Closed loop system
sys = ss((A - B*K), B, C, D);

% Run response to initial condition
t = 0:0.005:30;
[y,t,x] = initial(sys, x0, t);
%figure
%plot(t, y)
% calculate angular acceleration
velocity = x(:,2)
accel = diff(velocity)
accel = accel/0.005
accel = [accel; 0]

% Calculate time of reaching steady state
threshold = 0.0001
t_steady = 0;
for i = 1:6001
    if abs(accel(i)) < threshold
        if abs(y(i)) < threshold
            if abs(velocity(i)) < threshold
                t_steady = i*0.005
                break;
            end
        end
    end
end
% plot angular a, p, v
figure
subplot(3,1,1)
plot(t,accel)
title('acceleration')
xlim([0 t_steady])
xlabel('time (sec)')
ylabel('m/s^2')
grid on;

subplot(3,1,2)
plot(t,y)
title('position')
xlim([0 t_steady])
xlabel('time (sec)')
ylabel('m')
grid on;

subplot(3,1,3)
plot(t,velocity)
title('velocity')
xlim([0 t_steady])
xlabel('time (sec)')
ylabel('m/s')
grid on;

% Calculate Force Effort
force_effort = 0
for i = 1:t_steady/0.005
    force_effort = force_effort + 0.005*accel(i)^2
end
disp(t_steady)

%% Calculate Force Input Command: u
u = zeros(1,0)
for i = 1:6001
    u(i) = -1*dot(K,x(i,:))
end
%%
u = transpose(u)
figure
plot(t,u)
xlim([0 t_steady])
xlabel('time (sec)')
ylabel('Force')
grid on
title('Command u Input')
