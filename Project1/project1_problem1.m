%Project 1 Problem 1 - AC Circuit Simulation
clear all 

%Parts A and B
%Initial values from the circuit and time constant
L = 4.5/1000;
RS = 0.1;
RL = 23.04;
phi = 90;
omega = 2*pi*60;
T = 2*pi/omega;
tau = L/RS;

%Used to find the phasor equation
B = 4800*sqrt(2)*exp(j*deg2rad(-phi))/(1+j*omega*tau);
magB = abs(B)
angleB = angle(B)*180/pi;

%The time step and time vector
delta_t = T/1000;
t = [0:delta_t:7*tau];

%Discrete time equations and a vector is used to find the inductor current
IL_0 = 0;
IS = 4800*sqrt(2)*cos(omega*t - deg2rad(phi));
IL = [];

a = delta_t/tau;
b = (1-delta_t/tau);

%Fill the inductor current vector using a discrete time equation
for n = 1:1:length(t)-1
    if n == 1
        IL = IL_0;
    end 
    
    IL(n+1) = a*IS(n) + b*IL(n);
end

%Plot the inductor current over time
figure(1);
plot(t,IL);
title('Inductor Current Over Time');
xlabel('Time (s)');
ylabel('Current (Amps)');

%Part C
clear all

%Initial values from the circuit and time constant
L = 4.5/1000;
RS = 0.1;
RL = 23.04;
phi = 90;
omega = 2*pi*60;
T = 2*pi/omega;
tau = L/RS;

%Used to find the phasor equation
B = 20.7433*sqrt(2)*exp(j*deg2rad(-phi))/(1+j*omega*(L/(RS+RL)))
magB = abs(B)
angleB = rad2deg(angle(B))

%The time step and time vector
delta_t = T/1000;
t = [0:delta_t:7*tau];

%Discrete time equations and a vector is used to find the inductor current
IL_0 = magB*cos((omega*0)+angle(B));
IS = 20.7433*sqrt(2)*cos(omega*t - deg2rad(phi));
IL = [];

a = delta_t/tau;
b = (1-delta_t/tau);
%Fill the inductor current vector using a discrete time equation
for n = 1:1:length(t)-1
    if n == 1
        IL = IL_0;
    end 
    
    IL(n+1) = a*IS(n) + b*IL(n);
end

%Plot the inductor current over time
figure(2);
plot(t,IL);
title('Current with Accurate Phi Value');
xlabel('Time (s)');
ylabel('Current (amps)');