clear, close all 

%%% Ejercicio1 %%%
    %Frecuencia de 50 hz/amplitud 
    f= 50;%hz
    %Voltaje
    V0= 10; %V    
    %¿Frecuencia angular(w)w=2pi*f=2pi/T? Voltaje--> v(t)= v0*cos(w*t)
    w= 2*pi*f;
    
    T= 1/f;%s (periodo)
    t= (0:0.0001:T);
    
    %Vector de voltaje en funcion de t 
    V= V0*exp(1i*w*t);
    
    %Definimos valores R,C,L(circuito paralelo)
    R= 10; %Ohm --> 1/R                ; IR=V/R
    L= 0.1; %H  --> XL= i*L*w       ; 
    C= 50e-6; %uF   --> XC= 1/i*C*w     ; IC=V/XC=V(i*C*w)

    %%Valores complejos ->1/X= 1/R + 1/L + 1/C
    XR= R; 
    XC= 1/1i*C*w;
    XL= 1i*L*w;

    %Calculo de intensidades
    IR= V/XR;
    IC= V/XC;
    IL= V/XL;

    %Itensidades usando solo la parte real de V 
    Vreal= real(V);
    IRreal= real(IR);
    ICreal= real(IC);
    ILreal= real(IL);

    %plot de V
    figure(1)
    subplot(211);
    plot(t, Vreal)
    %plot de intensidad
    subplot(212); hold on
    plot(t, IRreal)
    plot(t, ICreal)
    plot(t, ILreal); 
    legend({'IR', 'IC', 'IL'}), hold off



    %calculo de potencia sabemos que --> P= I*V
    PR= Vreal.*IRreal;
    PL= Vreal.*ILreal;
    PC= Vreal.*ICreal;

    figure(2)
    hold on
    plot(t, PR)
    plot(t, PL)
    plot(t, PC)
    hold off

    %Calculo de potencia total PT= PR+PL+PC
    PT= PR + PL + PC;
    figure(3)
    plot(t, PT)

    %Calculo de potencia TOTAL media disipada
    PTdisipada= mean(PT);

    %Calculo de potencia media disipada de cada componente de resistencia 
    PRdisipada= mean(PR);
    PLdisipada= mean(PL);
    PCdisipada= mean(PC);

    %Sabemos que el voltaje eficaz es Vrms=V0/sqrt(2)
    Vrms= V0/sqrt(2);