function y=filtro_FIR(b,x)
    % Calcula filtrado FIR de señal de entrada x[] usando los coeficientes de b[]
    % La señal resultante es el argumento de salida y[]
    y= 0*x;
    p= length(b);
    xlast= zeros(1,p);

    for n=1:length(x)
        xlast= [x(n) xlast(1:end-1)]; 
        y(n)= sum(b.*xlast);

    end


end