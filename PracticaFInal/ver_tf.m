function ver_tf(x,fs,color,tipo)
% ver_tf(x,fs,color,tipo)
% Simula una TF continua de una señal x(t) 
% Hay que darle la frecuencia de muestreo para que pueda relacionar 
% las muestras con el tiempo real en el que ocurrieron
% 
% ver_tf(x,fs) representa el modulo al cuadrado de la TF (espectro de potencia) 
%              de x en una escala logaritmica (decibelios) en color azul.
% ver_tf(x,fs,col) pinta en color col.
% 
% tipo puede ser 'todo' (pintamos ambos ejes de frecuencias) o 
%                'semi' (pintamos unico eje de frecuencias).
% 



N=512; %N=2048;

if nargin<4, tipo='todo'; end
if nargin==2, color='b'; end

%mindB=-100; maxdB=-40;


[Px f] = pwelch(x,N,N/2,[],fs);

if strcmp(tipo,'semi') 
  rx=[0 fs/2]/1000;
else
 Px = [Px(end:-1:2)' Px'];
 f  = [ -f(end:-1:2)'  f'];
 rx=[-fs/2 fs/2]/1000;
end 


f=f/1000;          % Presentar eje X en KHz
dB=10*log10(abs(Px));   % Eje de potencia en dB

mindB=floor(min(dB)/10)*10;
maxdB=ceil(max(dB)/10)*10;

sx=(fs/1000)/10;
xt=[-fs/2000:sx:fs/2000];
yt=[mindB:10:maxdB];


plot(f,dB,color); 
set(gca,'Xlim',rx,'Xtick',xt,'Ylim',[mindB maxdB],'Ytick',yt); 
grid on;
xlabel('Frecuencia (Khz)');
ylabel('10 log_{10} (|X(\omega)|^2)');