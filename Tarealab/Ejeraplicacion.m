clear all, close all
%-----------------------------------------------------------------------
[x, fs]= audioread('drone.wav');
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
centro= length(rg)/2; 
res=zeros(1,46);
centroTrozo=zeros(1,46);
contador=1;
while rg(end) <= length(x1)
    
    [C, m]= correlacion(x1(rg,1), x2(rg,1), 85);
    [valorMax, posMax]= max(C);
    desfase= m(posMax);
    res(contador)=desfase;
    centroTrozo(contador)= rg(centro);
    %aumento del salto
    rg=rg(1)+s;
    rg= rg: rg+S;

    longitud= length(res);

    if(contador==1)
        figure(2)

        plot(m,C,'b'), hold on
    end
    contador= contador +1;
end

plot(m,C,'r'), hold off
figure(3)
resTiempo= centroTrozo./fs;
plot(resTiempo,res)


%--- Cálculo del ángulo de azimuth 
desfaseTiempo=res./fs;
azimuth= asind(((c*desfaseTiempo)/D));%inversa del seno en grados
figure(4)
plot(resTiempo, azimuth)

