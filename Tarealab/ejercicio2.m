close all, clear all 

% ejercicio 2

fs= 44100;
t=(0:1/fs:1)';
f1=73;%Hz
s1= sin(2*pi*f1*t);

f2= 77;%Hz
s2= sin(2*pi*f2*t);

subplot(211);
plot(t, s1, 'b', t, s2, 'r')
subplot(212); 
plot(t, s1+s2)