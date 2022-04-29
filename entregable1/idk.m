clear, close all
%%%%%%%%%%%%%%%%%% expresion H2(w) %%%%%%%%%%%%%%%%%%
R2= 10000; %ohmios
R1= 1000; %ohmios
C2= 5.3e-9; %F
f=(0:100000);
w=2*pi*f; 


X2= (1./( (1/R2) + (1i*C2.*w)));
H2= -(X2)/(R1);
moduloH2= abs(H2);


%grafica en db
figure(1)

dbH2=20*log10( moduloH2);
busqueda= find(dbH2==-3);
k= find(dbH2<-3 & dbH2>-3.001);
[minimo imin]= max(dbH2(k));
frEstimada= f(k(imin));


semilogx(f,dbH2,'linewidth',2)
xlabel('Frecuencia (Hz)','FontWeight','bold');
ylabel('dB = 10∙log_{10}(|H|^2)','FontWeight','bold');

%grafica en grados
fase_H= (angle(H2)*180)/pi;
figure(2)
semilogx(f,fase_H,'linewidth',2);
xlabel('Frecuencia (Hz)','FontWeight','bold');  
ylabel('Fase(H) en grados','FontWeight','bold');
%ylim([ -100 10])


%%%%%%%%%%%%%%%%%% expresion H1(w) %%%%%%%%%%%%%%%%%%
C1= 10e-6;
XC1= (1./(1i*C1*w));

Vin=H2;

H1= ((R1)./(R1 + XC1)).*(Vin);

modH1= abs(H1);
figure(3)
dbH1= 20*log10( modH1);
semilogx(f, dbH1,'b', 'linewidth',2), hold on
semilogx(f, dbH2, 'r','linewidth',2), hold off
xlabel('Frecuencia (Hz)','FontWeight','bold');  
ylabel('dB','FontWeight','bold');

wc1= (1)/(R1*C1);
fc1= (wc1)/(2*pi);
fc11= 1/(2*pi*R1*C1)
%amplificacion total
realH1= real(dbH1);
dbH1(1)=0;
amplificacion= sum(dbH1);

%%%%%%%%%%%%%%%%%% expresion Htotal(w) %%%%%%%%%%%%%%%%%%
%modulo total
H= (-R2/R1);

Htotal= H.*H2.*H1;
moduloHtotal= abs(Htotal);
dbTotal= 20*log10(moduloHtotal);
figure(4)
semilogx(f, dbTotal, 'LineWidth',2);
xlabel('Frecuencia (Hz)','FontWeight','bold');  
ylabel('Fase(H) en grados','FontWeight','bold');
frecCorteH2= (1)/(2*pi*R2*C2);

%filtro duplicado
Hdoble= Htotal.^2;
moduloHdoble= abs(Hdoble);
dbDoble= 20*log10(moduloHdoble);
figure(5)
semilogx(f, dbDoble, 'LineWidth',2);
xlabel('Frecuencia (Hz)','FontWeight','bold');  
ylabel('Fase(H) en grados','FontWeight','bold');
%en grados
fase_HTotal= (angle(Hdoble)*180)/(pi);
figure(6)
semilogx(f,fase_HTotal,'linewidth',2);
xlabel('Frecuencia (Hz)','FontWeight','bold');  
ylabel('Fase(H) en grados','FontWeight','bold');



