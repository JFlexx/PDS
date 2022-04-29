clear all, close all

n=0:80;
ruido= 0.2*rand(1,length(n));
xr= 3*cos(0.2*pi*n) + ruido;

a= [1];
b=[1/3 1/3];
yr=filter(b,a,xr);
figure(1)
plot(n, xr,'r', n, yr,'b')