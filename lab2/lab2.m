clear all, close all

N=50;
k=(0:N); 

a=exp(-(k/4).^2);
b=0*k; 
a0=a(1); a=a(2:end); b=b(2:end);

T0= 2; %s
fs= 44100; %Hz

t=(-1:(1/fs):1)';

x= a0;
for k= 1:50
    x= (x) + (a(k)*cos(2*pi*(k/2)*t));
    plot(t, x)
    pause(0.1) 
end


