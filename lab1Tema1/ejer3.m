clear, close all 
%%Ejercicio 3
    %Circuito RLC
    R= 10;  %ohmios 
    L= 0.2; %H
    C= 10e-6;  %F o 10 uF
    f= 50; %hz
    w= 2*pi*f;
    %Valores de las reactancias 
    XR= R; 
    XC= 1/1i*C*w;
    XL= 1i*L*w;

    %calculo de módulo z en serie
    Z= R + XC + XL;
    Z2= R + 1i*(L*w - (1/C*w));
    %modulo z
    Zmodulo= sqrt(R^2 + (L*w-(1/C*w))^2 );
 

    %desfase
    desfase= (1/C*w)*exp(-1i*pi/2);
    %de radianes a grados 
    desfaseGrados= rad2deg(desfase);

    %Frecuencia de resonancia
    wr= 1/ sqrt(L*C);
    
    %Representación 
    rangoF= 10:1000;
    wRango= 2*pi*rangoF;
    ZmoduloRango= sqrt(R^2 + (L*wRango-(1/C*wRango)).^2 );
    figure(1)
    semilogx(rangoF, ZmoduloRango);


    %Para una amplitud V0= 10 V
    V0=10;  % 10V 
    I0= V0./ZmoduloRango;
    figure(2)
    semilogx(rangoF, I0)

    %Máximos de frecuencia en lados del gráfico
    [maxZmodulo, iModulo] = max(ZmoduloRango);
    [maxI0, iI0] = max(I0); 
    maxFrecModulo= rangoF(iModulo);
    maxFrecI0= rangoF(iI0);
    
    %Ancho de banda
    anchoB= maxZmodulo - maxI0;

    %factor Q= frecuencia max/ ancho de banda