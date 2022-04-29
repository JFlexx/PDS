clear all, close all
n= -4:4;

x= funX(n);
subplot(1,2,1)
stem(n, x)
subplot(1,2,2)
a= [1];
b=[1/3 1/3];
y=filter(b,a,x);
stem(n,y)

%valores de las secuencia yc
n= 0:4;
yc=(1/3)*(funX(n+1) + funX(n) + funX(n-1));
figure(2)
stem(n,yc)

%%%%%%%%%%%%%%%%%%%%%
n=0:80;
x= 3*cos(0.2*pi*n) + cos(0.9*pi*n);

yc=(1/3)*(funX(n+1) + funX(n) + funX(n-1));
a= [1];
b=[1/3 1/3];
y=filter(b,a,x);
figure(3)
plot(n, x,'r', n, y,'b')

figure(4)
plot(n, y,'r', n, yc,'b')
