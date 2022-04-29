clear all, close all

n=0:80;
x= 3*cos(0.2*pi*n) + cos(0.9*pi*n);


a= [1];
b=[1/3 1/3];
y=filter(b,a,x);
figure(1)
plot(n, x,'r', n, y,'b')

