clear, close all
%Ejercicio 3b 
R= 50;  %ohmios
L= 0.5; %H
C= 1e-6 ;%F

%Frecuencia de resonancia 
Wr= 1/ sqrt(L*C);

rangoF= 10:1000; %Hz
wRango= 2*pi*rangoF;
ZmoduloRango= sqrt(R^2 + (L*wRango-(1/C*wRango)).^2 );
ZmoduloRangoInv= sqrt(R^2 + ( (1/L*wRango)-(C*wRango)).^2 );
ZmoduloRangoInv2= sqrt(R^2 + ( (1/L*wRango)+(C*wRango)).^2 );
figure(1)
loglog(rangoF, ZmoduloRango);
figure(2)
loglog(rangoF, ZmoduloRangoInv2);
