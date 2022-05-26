clear all, close all
x=randn(1,8); 
N= length(x);
X=fft(x);

xp=x(1:2:7);
xi=x(2:2:8);

XP=fft(xp);
Xi=fft(xi);

Xp= [XP XP];
Xi= [Xi Xi];

X2=Xp+exp(-1i*(2*pi)/N*(0:7)).*Xi;


x=randn(1,32768); 
X=fft(x);

tic
for k=1:100
    X2= fast_dft(x);
end
toc

X1= slow_dft(x);

figure(1)
plot(X-X1, 'r.')
figure(2)
plot(X-X2, 'r.')

