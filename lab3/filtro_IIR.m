function y=filtro_IIR(b,a,x)
    % Calcula filtro IIR con recursión sobre señal de entrada x[] usando 
    % Coeficientes {b} (sobre las entradas anteriores) 
    % Coeficientes {a} (sobre las salidas anteriores)


    y= 0*x;
    a= a(2:end);
    P= length(b);
    Q= length(a);
    xlast= zeros(1,P);
    ylast= zeros(1,Q);

    for n=1:length(x)
        xlast= [x(n) xlast(1:end-1)]; 
        y(n)= sum(b.*xlast) - sum(a.*ylast);
        ylast= [y(n) ylast(1:end-1)]; 

    end
end