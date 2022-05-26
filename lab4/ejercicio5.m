clear all, close all
load tren_h.mat
figure(1), hold on
plot(h1)
plot(h2), hold off
fs=4410; 

[H1 f1] = freqz(h1,[1],500,fs);
[H2 f2] = freqz(h2,[1],500,fs);

figure(2)
f1=f1/1000;%en khz
semilogy(f1,abs(H1),'b');hold on, %pintamos módulo
f2=f2/1000;%en khz
semilogy(f2, abs(H2), 'r'), hold off

