%Project 1 Problem 5 - Robot Arm
clear all

%Parts D + E
%Values provided for the circuit
L = 0.01;
R = 3.38;
K = 0.029;
J = 2*10^-4;
B = 0.5*10^-5;

%Create the time step and the time vector
Tau = L/R;
delta_t = Tau/100;
t = [0:delta_t:20];

%Set the initial conditions
i_0 = 0;
omega_0 = 0;
theta_0 = 0;
v_a = 10;

%Declare vectors for current, speed, and angle
i_a = zeros(1,length(t));
omega = zeros(1,length(t));
theta = zeros(1,length(t));

%Fill i_a and omega_a using the discrete time equations
for n = 1:1:length(t)-1
    if n == 1
        i_a(n) = i_0;
        omega(n) = omega_0;
        theta(n) = theta_0;
    end
    
    i_a(n+1) = i_a(n) + (delta_t*((v_a/L) - ((R/L)*i_a(n)) - ((K/L)*omega(n))));
    omega(n+1) = omega(n) + (delta_t*(((K/J)*i_a(n)) - ((B/J)*omega(n))));
    theta(n+1) = (omega(n)*delta_t) + theta(n);
end

%Create a tiled layout to have multiple graphs in the same window
figure(1)
tiledlayout(3,1)

%Current graph
nexttile
plot(t,i_a)
title('Current (ia)');
xlabel('Time (s)');
ylabel('Current (amps)')

%Speed graph
nexttile
plot(t,omega)
title('Motor Speed (omega)');
xlabel('Time (s)');
ylabel('Speed (rad/s)')

%Angle graph
nexttile
plot(t,theta)
title('Motor Angle (theta)');
xlabel('Time (s)');
ylabel('Angle (radians)')


clear all

%Part G
%Values provided for the circuit
L = 0.01;
R = 3.38;
K = 0.029;
J = 2*10^-4;
B = 0.5*10^-5;

%Create the time step and the time vector
Tau = L/R;
delta_t = Tau/100;
t = [0:delta_t:50];

%Set the initial conditions
i_0 = 0;
omega_0 = 0;
theta_0 = 0;
k_ptheta = 1;
theta_ref = 45;

%Declare vectors for current, speed, and angle
i_a = zeros(1,length(t));
omega = zeros(1,length(t));
theta = zeros(1,length(t));
v_a = zeros(1,length(t));

%Fill i_a and omega_a using the discrete time equations
for n = 1:1:length(t)-1
    if n == 1
        i_a(n) = i_0;
        omega(n) = omega_0;
        theta(n) = theta_0;
    end
    
    v_a(n) = k_ptheta*(theta_ref-theta(n)); 
    i_a(n+1) = i_a(n) + (delta_t*((v_a(n)/L) - ((R/L)*i_a(n)) - ((K/L)*omega(n))));
    omega(n+1) = omega(n) + (delta_t*(((K/J)*i_a(n)) - ((B/J)*omega(n))));
    theta(n+1) = (omega(n)*delta_t) + theta(n);
end

%Angle graph
figure(2)
plot(t,theta)
title('Motor Angle (theta)');
xlabel('Time (s)');
ylabel('Angle (degrees)')