
clear, close all

    %problema 6

    n= -2:2; 
    x= myX(n);
    
    %1
    figure(1)
    stem(n, x)
    title('Secuencia x')

    %2
    x2= myX(-n);
    figure(2)
    stem(n, x2)
    title('Secuencia x2')

    %3
    x3= -x;
    figure(3)
    stem(n, x3)
    title('Secuencia x3')
    
    %4
    x4= myX(n-1);
    figure(4)
    stem(n, x4)
    title('Secuencia x4')

    %5
    x5= myX(n).*fDelta(n+1);
    figure(5)
    stem(n, x5)
    title('Secuencia x5')


    %x6
    x6= myX(n).*( fDelta(n+1) + fDelta(n) + fDelta(n-1));
    figure(6)
    stem(n, x6)
    title('Secuencia x6')

    %x7
    x7= myX(n).*( fEscalon(n-1) - fEscalon(n-2) );
    figure(7)
    stem(n, x7)
    title('Secuencia x7')



