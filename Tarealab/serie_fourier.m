function [a0, a, b]=serie_fourier(x,m)
    % Entrada: x --> secuencia con un periodo completo de la señal
    % m --> numero de coeficientes {ak},{bk} a calcular
    % Salida : a0  +  a = {ak} +  b={bk} vectores con m valores cada uno
    N=length(x); x=reshape(x,1,N);
    a0= mean(x);
    
    %bucle
    for k= 1:m
        c=cos((2*pi/N)*k*(0:N-1));
        s=sin((2*pi/N)*k*(0:N-1));         
        
        a(k)= (2/N)*sum(x.*c);   
        b(k)= (2/N)*sum(x.*s);
    
    end

end