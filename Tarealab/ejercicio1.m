clear all, close all 
x=randn(1,1000);
[C,m]=xcorr(x,x,200);
[C1,m1]=correlacion(x,x,200);
figure(1)
plot(m1, C1)

%-----------------------------------------------------------------------
%gráfica de audio
%x=audioread('ecg.wav',[1 1000]);
[C,m]=correlacion(x,x,200);

figure(2)
plot(m, C)

