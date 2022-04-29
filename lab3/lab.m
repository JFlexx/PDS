clear all, close all

b= [0.7 0.3];
x= (1:5);
y= filtro_FIR(b,x);

%%%%%%%%%%%%%%%%%%%%% señal con ruido
A= 1;
f= 300;
fs= 22050;
t=(0:1/fs:1)';
x= A*sin(2*pi*f*t);

x = x + 0.1*randn(size(x));
%sound(x, fs)
figure(1)
plot(t, x)

%%%%%%%%%%%%%%% Filtro FIR
N=6; n=(-N:N); 
b=(1+cos(n*pi/(N+1)))/2; 
b=b/sum(b);
figure(2)
stem(n,b)

%%%%%%%%%%%%% Filtro FIR y1 e y2

y1 = filtro_FIR(b,x);  
y2 = filter(b,1,x);
figure(3)
plot(t,y1-y2)


show2(x,y1,fs) 

