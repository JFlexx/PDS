clear all, close all
%-------------------Datos ejer 1C)---------------------
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

%B) Demulacion: Aplicacion
[I2, Q2]=demodulador(IQ,2000,0.0,fs);
%------------------------------------------------

%---Método alternativo
%fase derivada I
n= length(I2);
resI2=[];
for i=2:n
    %Para el punto inicial
    if i==2
        resI2=[resI2; I2(i)-I2(i-1)];

    %si estamos en el ultimo punto
    elseif i==n
        resI2=[resI2; I2(i)-I2(i-1)];

    else%para los intermedios
        resI2=[resI2; (I2(i+1)-I2(i-1))/2];
    end
end
resI2=[resI2; 0];%coloco 0 al final(para mismo tam que Q2)

%fase derivada Q
n= length(Q2);
resQ2=[];
for i=2:n
    %Para el punto inicial
    if i==2
        resQ2=[resQ2; Q2(i)-Q2(i-1)];
    %si estamos en el ultimo punto
    elseif i==n
        resQ2=[resQ2; Q2(i)-Q2(i-1)];
    %para los intermedios
    else
        resQ2=[resQ2; (Q2(i+1)-Q2(i-1))/2];
    end
end
resQ2= [resQ2; 0];%coloco un 0 al final(para mismo tam que I2)

DerivadaFase= (I2.*resQ2)-(Q2.*resI2);
figure(1)
plot(t,DerivadaFase)