clear all, close all

%ejercicio2
%1)------------------
a= [1 -0.95];%y
b= [0.05];%x
n= 200;%puntos
[H,w]= freqz(b,a,n);
fs= 40000;%hz
figure(1)
subplot(211); plot(w,abs(H));%pintamos módulo 
subplot(212); plot(w,angle(H)); % Pintamos fase. 

%filttro 1
fvtool(b,a,'fs',40000 );%2

%filtro 2
a= [1];%y
b= [0.25 -0.5 0.25];%x
fvtool(b,a,'fs',40000 );%3


%filtro muesca 
a=[1 -1.84 0.94];%y
b= [0.97 -1.84 0.97];%x
fvtool(b,a,'fs',40000 );%4

%filtro en funcion alfa
%---alfa= 0.05
alfa= 0.05;
a= [1 -(1-alfa)];
b= [(alfa-1) 1];
fvtool(b,a,'fs',40000 );%5
%---alfa= 0.95
alfa= 0.95;
a= [1 -(1-alfa)];
b= [(alfa-1) 1];
fvtool(b,a,'fs',40000 );%6

%ejercicio 3
%---funcion pulso
    %alfa=0.95
    n=(-30:70); p=exp(-(n/4).^2);
    figure(7)
    stem(n,p,'b'), hold on
    y = filter(b,a,p);
    stem(n,y, 'r'), hold off
    
    
    alfa=0.05;
    a= [1 -(1-alfa)];
    b= [(alfa-1) 1];
    figure(8)
    stem(n,p,'b'), hold on
    y= filter(b,a,p);
    stem(n,y, 'r'), hold off
