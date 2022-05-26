clear all, close all
%---------------EJERCICIO 1A)------------------
load x_signal.mat
fs=20000;
t= (0:1/fs:1)';

%a)Modulacion
A=1;
dt= 1/fs;
sumatorio=cumsum(x);%sumatorio de la formula
k=2000;
fase= k*dt*sumatorio;

%calculo de I y Q
I= A*cos(fase);
Q= A*sin(fase);

%portadora fc
fc= 2000;
IQ= (I.*cos(2*pi*fc*t)) - (Q.*sin(2*pi*fc*t));
%figure; spectrogram(IQ,512,[],[],fs)

%----------------ejercicio a-------------
%3) Espectrograma o transformada Fourier local
% fk= k*fs/N;
% tn= (n*s)/fs;


XX= [];%guarda datos señal
N=256;%tamaño de los bloques a usar(S)
S=N/2;%salto de las muestras(s)
rg= (1:N);%muestras del primer bloque a procesar
while(rg(end)<length(IQ))
    X= IQ(rg);
    X=fft(X);%fft
    XX=[XX X];%guardo res
    rg=rg(1)+S;%suma del salto 
    rg= rg: rg+N-1;%desde el salto hasta el tam del bloque
end
%modulo
XX= abs(XX);
%Muestras por encima de k son redundantes(K=N/2)
%nos quedamos con las muestrtas redundantes (1:K)
k= N/2;
XX= XX(1:k,:);%xxredundante

imagesc(log(1+XX));

%vectores Fk y Tn
Fk=((1:k).*fs)/N;%k-indices vertical

n= 1:length(XX);
Tn= (n*S)/fs;%n-indices horizontal
imagesc(log(1+XX),'Ydata',Fk,'Xdata',Tn)
xlabel('xxxx'),ylabel('yyyy')
