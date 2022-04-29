clear all, close all
%-----------------------------------------------------------------------
[x, fs]= audioread('mosquito.wav');
%plot(x)
sound(x, fs)
D= 0.65;%metros
c= 340; %m/s
x1= x(:,1);
x2= x(:,2);
[C, m]= correlacion(x1,x2,85);
figure(1)
plot(m, C)
[maximo, Ipos]= max(C);
%posiciondron= find(C==85);
posMax= m(Ipos);

%---------------------------------------%
S=8820; %fragmentos de señal(muestras)
s= S/4; %el salto entre fragmentos de señal(muestras)


rg= 1:S;  
centro= length(rg)/2;%obtengo el tamaño del centro para cada trozo de muestra
res=zeros(1,46);% guardo los defases para cada trozo a analizar(vector columna)
centroTrozo=zeros(1,46);%guardo los centros de cada trozo de muestra
contador=1;
while rg(end) <= length(x1)
    
    [C, m]= correlacion(x1(rg,1), x2(rg,1), 85);
    [valorMax, posMax]= max(C);
    desfase= m(posMax);%obtengo el desfase
    res(contador)=desfase;%Guardo los DESFASES de cada trozo en el vector columna
    centroTrozo(contador)= rg(centro);%obtengo los centros de cada trozo
    %aumento del salto
    rg=rg(1)+s;
    rg= rg: rg+S;
    
    %gráfica para las primeras muestras 
    if(contador==1)
        figure(2)

        plot(m,C,'b'), hold on
    end
    contador= contador +1;
end

%gráfica para las últimas muestras 
plot(m,C,'r'), hold off

%-------- resTiempo- son los tiempos del centro de cada trozo que se analiza 
% Se divide entre fs para obtener los tiempo de los centro de cada trozo
figure(3)
resTiempo= centroTrozo./fs;
plot(resTiempo,res)

%--------- Cálculo del ángulo de azimuth 
desfaseTiempo=res./fs;
azimuth= asind(((c*desfaseTiempo)/D));%inversa del seno en grados
figure(4)
plot(resTiempo, azimuth)

