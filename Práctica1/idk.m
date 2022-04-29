clear, close all

%Dar la expresion 
% combinacion de R2 y C2
C2= 1/ 1i*C*w;
X2= 1/R2 + 1/C2; 


Donde H2= -X2/R1
Donde X2= 1/R2 + 1/C2; 
Donde C2= 1/i*C*w;

H(w)=(-R2/R1)* H2 = (-R2/R1) * (-X2/R1)= ((-R2)* -(1/R2 + 1/C2))/R1
= (R2/R2 +R2/C2 ) /R1= (1 + (R2*i*C*w))/ R1


Donde Donde X2= 1/R2 + 1/C2; 
Donde C2= 1/i*C*w;

R2= 10e3;
C2= 5.3e-9;
H2= -X2/R1 =  -(1/R2 + 1/C2)/R1 =-(1/R2 + i*C*w)/R1

moduloH2= abs(H2);

abs(H2)^2= H2^2= -(1+ i*C*w*R2)^2 /(R1*R2)^2
despejando => (-1/R2*R1)^2 +(-1/C2*R1)^2 
