
clear, close all; 
%problema 1
%1
%a)
 
    A = 3;%amplitud
    f=2;%frecuencia lineal
    t=(0:0.0001:1);
    w= 2*pi*f;%frecuencia angular
    x= 3*cos(2*f*pi*t);
    
    %contestacion: hay 2 ciclos
    %periodo
    T= 1/f;%contestacion: un ciclo dura 0.5 segundos
    figure(1)
    plot(t,x)
    xlabel('t','FontWeight','bold');  
    ylabel('señal x(t)','FontWeight','bold');

    %maximo
    [maximo, imax]= max(x); %contestacion: max 3
    [minimo, imin]= min(x); %contestacion: min -3
    
    interMax= t(imax);
    interMin= t(imin);
    %contestacion: el maximo en el intervalo 0 y el minimo en el 0.25
    %también se puede mirar la grafica y señalar los puntos max y min del
    %intervalo [0:0.5]

%b)
    x2= cos(2*pi*4*f*t);
    amplitudX2 = max(x2);%amplitud
    imaxX2= find(x2==amplitudX2);
    periodoX2= t(imaxX2(2));%periodo
    frecuenciaX2= 1/periodoX2;%frecuencia
    wX2= 2*pi*frecuenciaX2;%frecuencia angular

    x3= 0.5*cos(2*pi*f*(t/2));
    amplitudX3= max(x3);%amplitud
    imaxX3= find(x3==amplitudX3);
    periodoX3= t(imaxX3(2));%periodo
    frecuenciaX3= 1/periodoX3;%frecuencia
    wX3= 2*pi*frecuenciaX3;%frecuencia angular


    figure(2)
    plot(t, x, 'r', t, x2, 'g', t, x3, 'b')
    %plot(t, x2, 'g')
    xlabel('t','FontWeight','bold');  
    ylabel('señales(t)','FontWeight','bold');


    
%2
    x4= x + x2 + x3;
    figure(3)
    plot(t, x4)
    xlabel('t','FontWeight','bold');  
    ylabel('señal ','FontWeight','bold');
    periodoX4= max(x4);
    minx4= min(x4);
    % es periodica porque la división de los periodos de 
    %la distintas funciones da un numero racional, por lo que se le
    %considerar periodo

%3
%-
    x5= 3*cos(4*pi*t - 0.4*pi);
    figure(4)
    plot(t, x, 'r', t, x5, 'go'), hold on
    
    %contestacion: que la onda sufre un retardo
    amplitudX5= max(x5);
    imaxX5= find(x5==amplitudX5);
    periodoX5= t(imaxX5(2))- t(imaxX5(1));%periodo(se mantiene)
    puntoMaximo= t(imaxX5(find(t(imaxX5) < 0.5)));%devuelve el punto donde es maximo dentro del rango de [0,T]

%- 
    %el tiempo de retardo
    t0= puntoMaximo - interMax ;%diferencias de amplitudes dentro del periodo
    xnew= 3*cos(2*f*pi*(t-t0));

    plot(t, xnew, 'b.'), hold off
    xlabel('t','FontWeight','bold');  
    ylabel('señal x(t)','FontWeight','bold');