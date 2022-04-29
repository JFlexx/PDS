clear all, close all
N=100;
t=2*pi*(0:N-1)/N; 
x=0.2+cos(2*t)-0.5*sin(4*t)+0.7*sin(t)-0.2*cos(8*t);
[a0,a,b]=serie_fourier(x,10);