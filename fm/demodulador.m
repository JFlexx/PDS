function [I,Q] = demodulador(IQ,f_local,ph0,fs)
    % Parametros de entrada:
    % IQ : señal modulada
    % f_local: frecuencia del oscilador local (en Hz)
    % ph0: fase inicial el oscilador local (rads)
    % fs: frecuencia de muestreo (Hz) de simulación
    % Parametros salida: I,Q: señales I y Q separadas.

    t= (0:1/fs:1)';
    oscilacionI= cos(2*pi*f_local.*t+ph0);
    oscilacionQ= sin(2*pi*f_local.*t+ph0);

    I= IQ.*oscilacionI;
    Q= -IQ.*oscilacionQ;
    
    wc=1000/(fs/2); B = fir1(64,wc);
    I=filter(B,1,I);
    Q=filter(B,1,Q);
end