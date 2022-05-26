
function X=slow_dft(x)   %  Slow DFT aplicando directamente la fórmula
   
    N= length(x);
    X=0*x;

    for k=0:N-1
        wk = exp(-1i*2*pi*(0:N-1)*k/N); 
        X(k+1)=dot(x,wk);

    end

end
