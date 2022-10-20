%Project 1 Problem 3 - AM Communications
clear all

%Part B
%Read in the file used for the porblem
fileID = fopen('problem3.bin', 'r');
x=fread(fileID,'single'); 
fclose(fileID);

%Initial frequency values 
f = 50*10^3;
f_samp = 2.205*10^6;

%Time step and created the time vector
delta_t = 1/f_samp;
t = [0:delta_t:(length(x)-1)*delta_t];

%Convert x to a row vector if it's a column vector
if ~isrow(x)
    temp_x = transpose(x);
    x = temp_x;
end

%Use the demod to get the value of x_out
demod = cos(2*pi*f*t);
x_out = x.*demod;

%Calculate the start and end indices
nstart = 10.5/delta_t;
nend = 10.6/delta_t;

%Create a tiled layout to have multiple graphs in the same window
tiledlayout(3,1)

%Graph 1
%Plot the subsection of x over time
t_subsec = t(1, nstart:nend);
x_subsec = x(1, nstart:nend);
nexttile
plot(t_subsec,x_subsec,'b-')
title('Graph 1');

%Used to put both graphs in the same plot
%Plot the subsection of x_out over time
hold on
x_out_subsec = x_out(1, nstart:nend);
plot(t_subsec,x_out_subsec,'r-')
xlabel('Time (s)');
ylabel('Voltage (V)');
hold off

%Graph 2
%Determine the start and end indices for graph 2
T = 1/f;
g2start = 10.6/delta_t;
g2end = round(((2*T)+10.6)/delta_t);

%Plot the subsection of x over time
g2_t_subsec = t(1, g2start:g2end);
g2_x_subsec = x(1, g2start:g2end);
nexttile
plot(g2_t_subsec,g2_x_subsec,'b-')
title('Graph 2');
xlabel('Time (s)');
ylabel('Voltage (V)');

%Used to put both graphs in the same plot
%Plot the subsection of x_out over time
hold on
g2_x_out_subsec = x_out(1, g2start:g2end);
plot(g2_t_subsec,g2_x_out_subsec,'r-')
hold off

%Part D
%Remember that y(t) = y1
%The initial values 
L = 1.6*10^-3;
C = 1*10^-6;
R = 28.135;
y1_0 = 0;
y2_0 = 0;

%Declare the vectors to hold y1 and y2
y1 = zeros(1,length(x_out));
y2 = zeros(1,length(x_out));

%Fill y1 and y2 using the discrete time equations
for n = 1:1:length(x_out)-1
    if n == 1
        y1(n) = y1_0;
        y2(n) = y2_0;
    end
    
    y1(n+1) = y1(n) + (delta_t*y2(n));
    y2(n+1) = (((1/(L*C))*x(n) - (1/(R*C))*y2(n) - (1/(L*C))*y1(n))*delta_t) + y2(n);
end

%Determine the start and end indices for the filter
filter_n_start = 10.58/delta_t;
filter_n_end = 10.586/delta_t;

%Find the subsection of x_out, x, and 2y to plot
filter_t_subsec = t(1, filter_n_start:filter_n_end);
filter_x_out_subsec = x_out(1, filter_n_start:filter_n_end);
filter_x_subsec = x(1, filter_n_start:filter_n_end);
filter_2y_subsec = 2*y1(1, filter_n_start:filter_n_end);

%Plot the subsection of x over time
nexttile
plot(filter_t_subsec,filter_x_subsec,'r-')
title('Part D Graph');
xlabel('Time (s)');
ylabel('Voltage (V)');

%Used to put both graphs in the same plot
%Plot the subsection of x_out and 2y over time
hold on
plot(filter_t_subsec,filter_x_out_subsec,'b-')
plot(filter_t_subsec,filter_2y_subsec,'g-')
hold off

%Part F
%Listen to the sound
sound(downsample(y1,100),22.05e3) 
