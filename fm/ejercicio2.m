close all, clear all

%ejercicio 2)
load IQ_data_FM; I=double(I); Q=double(Q);

%reconstruir fasor
R= complex(I, Q);
prod= 0*R(1:end-1);
n= length(R);
for k=2:n
    prod(k-1)=R(k)*conj(R(k-1));
end
fase2= angle(prod);
difFase2= diff(fase2);

ver_tf(difFase2,fs,'r','semi');

wc=15000/(fs/2); B = fir1(150,wc);
fvtool(B,1,'fs', fs);% llamamos a fvtool 
xf = filter(B,1,difFase2);
ver_tf(xf,fs,'r','semi');

%sound(xf,fs)

muestras= 1:fs;
fsFinal= muestras(1:5:end);
newFs= length(fsFinal);
sound(xf,190000)
maxAudio= max(xf);
minAudio= min(xf);