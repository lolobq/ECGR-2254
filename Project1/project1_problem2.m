%Project 1 Problem 2 - High Pass Audio Filter
clear all

%Part C
%Load the audio file
load('sampleaudio.mat');

%Values from the circuit
R = 1;
C = 265.26*10^-6;
T = 1/Fs; %Fs is the frequency variable that's loaded in from the audio file
Tau = R*C;

%Find the time step and fill the time vector
delta_t = T;
t = [0:delta_t:(length(x)-1)*delta_t];
lenT = length(t);

%Declare the variables to fill the output voltage using discrete equations
y = zeros(length(t)-1,1);
a = Tau/(delta_t + Tau);

%Fill the output vector using a discrete time equation
y(1) = x(1);
for n = 1:1:length(t)-1
    y(n+1) = a*y(n) + a*(x(n+1) - x(n));
end

%Part D
%Play the sound
sound(y,Fs);

%Part E
%Subplot is used to plot both the input and output voltage
subplot(2,1,1);
plot(t,x);
title('Input');
ylabel('Voltage(V)');
xlabel('Time(s)');

subplot(2,1,2);
plot(t,y);
title('Output');
ylabel('Voltage(V)');
xlabel('Time(s)');