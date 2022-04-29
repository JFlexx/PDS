clear all, close all 

%%%%%%%%%%%%%%%%%

 
%y(n) = 0.2*x[n]+0.8*y[n-1] 
b=0.2;
a=[1 -0.8];
x=(1:10);

y= filtro_IIR(b,a,x);
%y2 = filter(b,a,x);

%%%%%%%%%%%%%%%%%%% distinta secuencia
x=[-1 2 -3 4 -5 6 -7 8 -9 10];
y= filtro_IIR(b,a,x);
%y2 = filter(b,a,x);

%%%%%%%%%%%%%%%%%%% 2 sinusoides
A=1;
f0= 500; %Hz
f1= 2000; %Hz 

fs= 22050; %Hz

t=(0:1/fs:1)';

x0= A*sin(2*pi*f0*t);
x1= A*sin(2*pi*f1*t);


y0 = filtro_IIR(b,a,x0);
y1 = filtro_IIR(b,a,x1);

show2(x0,y0,fs) 
show2(x1,y1,fs) 
% show2(x1,y,fs) 

