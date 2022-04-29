clear all, close all


%%%%señal de impulso 

x=zeros(1,50); x(1)=1;
figure(1)
% stem(x)
N=6;n=(-N:N); b=(1+cos(n*pi/(N+1)))/2; 
b=b/sum(b);
figure(1)
stem(b)

y = filtro_FIR(b,x);  
figure(2), hold on
stem(y)

%%%%%%%%%%%%%%%

b=[0.05];%x
%a=[1 -0.95];%y
a=[1 -1.02];%y

y= filtro_IIR(b,a,x);
stem(y,'r'), hold off

