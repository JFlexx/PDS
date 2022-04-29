clear, close all

%valores de k
k= -3:3;
f0= 25;%hz
www= 2*pi*f0;
xk= (-4)./((pi^2)*(k.^2));
figure(1)
stem(k*f0, xk)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t=(0:0.0001:0.12);
w0= 2*pi*f0;
k1=1;
k3=3;   
figure(2)
sk1= (-4)./((pi^2)*(k1^2)).*cos(k1*w0.*t);
sk3= (-4)./((pi^2)*(k3^2)).*cos(k3*w0.*t);
subplot(2, 1, 1)
plot(t, sk1)
subplot(2, 1, 2)
plot(t, sk3)

%%%%%%%%%%%%%%%%%%%%%%
w= (-pi:0.01:pi);
Xw= (1-0.25)./(1+0.25-cos(w));
[picoMaximo, i]= max(Xw);
figure(3)
plot(w./2*pi, Xw),hold on


%%%%%%%%%%%%%%%%
n=0;
xm= 2* ((1-0.25)./(1+0.25-cos(w))).* cos(pi.*(n/2)).* exp(1i*w.*n);
figure(4)
subplot(2 ,1 ,1)
plot(w, Xw)
subplot(2 ,1 ,2)
plot(w, xm)

%%%%%%%%%%%%%%%%%%%%%%%%%

yn= (1-0.25)./(1+0.25-cos(w)) * exp(-1i*pi*n)  .* exp(1i*w.*n);
figure(5)
subplot(2 ,1 ,1)
plot(w, Xw)
subplot(2 ,1 ,2)
plot(w, yn)



%%%%%%%%%%%%%%%%%%%%%%
