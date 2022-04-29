close all, clear all 

[x, fs]= audioread('diapason.wav');
%sound(x,fs)

%--------------
t=(0:1/fs:8)';
f= 442;
A= 0.1;
sinusoide= A*sin(2*pi*f*t);
%sound(sinusoide,fs)

%suma de señales
sintetica= x + sinusoide;
%sound(sintetica, fs)
figure(1)
plot(t, sintetica)

%-----------------------------------
S=8820; %fragmentos de señal(muestras)
rg= 1:S; 
%rg2= 176400:176400+S;

muestraSenal= x(rg);
[a0,a,b]=serie_fourier(muestraSenal, 200);
figure(2)
plot(a.^2+b.^2, 'ro:')
k=88;%%valor obtenido de la gráfica, k=88
N=200;%muestras
fk= k*(fs/200);

%---- Usando frecuencias armónicas(fk) en vez de k en el eje X
ks= 1:200;
fks= ks*(fs/200);
figure(3)
plot(fks, a.^2+b.^2, 'ro:')