clear all, close all

[x fs]=audioread('instrumento.wav');
sound(x, fs)
N= 1200;
duracion= N/fs;
xx=x(5000+(1:1200)); 
%plot( xx)

t=2*pi*(0:N)/N; 
[a0,a,b]=serie_fourier(xx,20);