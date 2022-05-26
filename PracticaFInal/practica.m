clear all, close all
%1) Modulación/Demodulación FM
%-Modulación/Demodulación de una señal "analógica"
load x_signal.mat

fs=20000;
t= (0:1/fs:1)';

figure(1)
plot(t,x)

%a)Modulacion
A=1;

dt= 1/fs;
sumatorio=cumsum(x);%sumatorio de la formula
k=2000;

fase= k*dt*sumatorio;

%calculo de I y Q
I= A*cos(fase);
Q= A*sin(fase);

figure(2)
subplot(311), plot(t,fase), xlim([0 0.2]);
subplot(312); plot(t,I), xlim([0 0.2]);
subplot(313); plot(t,Q), xlim([0 0.2]);

%portadora fc
fc= 2000;
IQ= (I.*cos(2*pi*fc*t)) - (Q.*sin(2*pi*fc*t));

%figure; spectrogram(IQ,512,[],[],fs)

%B) Demulacion: Aplicacion
[I2, Q2]=demodulador(IQ,2000,0.0,fs);

%reconstruir fasor
R= complex(I2, Q2);
%fase
fase= angle(R);

DerFase= diff(fase);
figure(3)
plot(t(1:end-1),DerFase)

%Fase retocada
prod= 0*R(1:end-1);
n= length(R);
for k=2:n
    prod(k-1)=R(k)*conj(R(k-1));
end
fase2= angle(prod);
difFase2= diff(fase2);
figure(4)
%plot(t(1:end-2),prod)
plot(t(1:end-1),fase2)
%Demodulacion de una señal binaria(BPSK)
bits = mod(t,0.05)<0.025;
fase= bits.*pi;
I= cos(fase);
Q= sin(fase);
fc= 2000; % Hz
fase0=0.0;
IQ= (I.*cos(2*pi*fc*t)) - (Q.*sin(2*pi*fc*t));

%demodulación
[I3, Q3]=demodulador(IQ,2000,0.0,fs);
%primeras 5000 muestras
I3muestras= I3(1:5000);
Q3muestras= Q3(1:5000);
figure(5)
plot(I3muestras)

figure(6)
plot(Q3muestras)
%show_IQ(I,Q)

%desajuste de pi/4
[I4, Q4]=demodulador(IQ,2000,pi/4,fs);
%show_IQ(I4,Q4)

%desajuste en frecuencia local
[I5, Q5]=demodulador(IQ,2001,0.0,fs);
%show_IQ(I5,Q5)