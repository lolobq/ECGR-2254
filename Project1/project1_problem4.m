%Project 1 Problem 4 - Complex Communications
clear all

%Part B
%Open the file and fill x_in
fileID = fopen('problem4.bin', 'r');
x_in = fread(fileID,'single'); 
fclose(fileID);
x_in = transpose(x_in);

%Declare frequency variables
f = 50 * 10^3;
f_samp = 2.205*10^6;
delta_t = 1/f_samp;

%Build the x vector by creating complex numbers from the values in x_in
x = [];
for n = 2:2:length(x_in)
    x(n/2) = x_in(n-1) + x_in(n)*j;
end

%Create the time vector
t = [0:delta_t:(length(x)-1)*delta_t];

%Turn x into a row vector if it's a column vector
if ~isrow(x)
    x = transpose(x);
end

%Declare x_3 and turn into a row vector if it's a column vector
x_3 = exp(-j*2*pi*f*t);
if ~isrow(x_3)
    x_3 = transpose(x_3);
end

%Compute x_out
x_out = x.*x_3;

%Part C
%Pulling the output and listening to the sound
x_imag = imag(x_out);
x_real = real(x_out);

z = downsample(x_imag, 100);
z2 = downsample(x_real, 100);

sound(z2)