% 2020.11.30 Jordan Gong
% After reading Fundamentals of Electric Propulsion, Ch2 Thruster Principle.
% Problems 2. Performace Comparison, ion thruster and hall thruster.

% Mission Specification
md = 800;           % deliver mass
deltaV = 8000;      % orbit
Pin = 3000;         % Power input
g = 9.8;

% Q: Find mp vs ISP; Trip time vs ISP for different thrusters.

% Ion Thruster
Vb = 1000:10:2000;
effT = 0.55;
effm = 0.85;
theta = 12 * pi/180;
current_ratio = 0.1;

% Hall Thruster
% Vb = 300:10:400;
% effT = 0.45;
% effm = 0.85;
% theta = 25 * pi/180;
% current_ratio = 0.15;

% Xenon propellant: Isp = 123.6* gamma* effm* sqrt(Vb)
gamma = cos(theta)* (1+0.707*current_ratio)/(1+current_ratio);
Isp = 123.6*gamma*effm*sqrt(Vb);
    
% mp = md*(exp^(deltaV/Isp*g)-1)
mp = md*(exp(deltaV./(Isp*g))-1);

figure;
subplot(3,1,1);
plot(Isp,mp);
xlabel('Isp')
ylabel('mp')

% Pjet = 0.5* mp_dot * Vex^2
Pjet = effT*Pin;
Vex = Isp*g;
mp_dot = 2*Pjet./Vex.^2;
T= mp_dot.*Vex;
subplot(3,1,2);
plot(Isp,T)
xlabel('Isp')
ylabel('Thrust');

% Trip time deltaT: deltaT = mp/mp_dot or T*deltaT = mp* Vex.
deltaT = mp./mp_dot;
subplot(3,1,3)
plot(Isp,deltaT/86400);
xlabel('Isp')
ylabel('Trip Time (days)');