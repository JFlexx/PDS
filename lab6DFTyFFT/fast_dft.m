function X=fast_dft(x)  % x = vector fila tamaño N = 2P % Output: su DFT X[] 
    N= length(x);
    %X=0*x;
    %fprintf('valor de logar %d\n', logar)
    if N==2
        X(1)= x(1) + x(2);
        X(2)= x(1) - x(2);

    else 
       
        xp=x(1:2:N);
        xi=x(2:2:N);
        Xp=fast_dft(xp);
        Xi=fast_dft(xi);
        Xp=[Xp Xp];
        Xi=[Xi Xi];
        X=Xp+exp(-1i*(2*pi)/N*(0:N-1)).*Xi;

    end


end