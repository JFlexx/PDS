clear all, close all 

% b= [1 0 0 0 0.1];%x
% a= [1];%y
% [H w]=freqz(b,a);
% plot(w,abs(H));% Pintamos módulo 

n=-20:20;
x=funcionX(n);
figure(1)
subplot(1, 3, 1)
stem(n,x )

y=funcionX(n) + 0.1*funcionX(n-4);
subplot(1, 3, 2)
stem(n,y)


y=funcionX(n) + 0.1*funcionX(n-4) - 0.1*funcionX(n-4);
subplot(1, 3, 3)
stem(n,y)

%H(w)
b= [1 0 0 0 0.1];
a=1;
w=(-pi:0.1 :pi);
[H]= freqz(b, a,w);
figure(2)
subplot(221); plot(w,abs(H)); % Pintamos módulo 

%in out sistema con eco
Tfx= 0.75./(1.25-cos(w));
subplot(222); plot(w,Tfx); % Pintamos módulo 

%sistema eliminar eco
b= [1 ];
a=1;
[H]= freqz(b,a,w);
subplot(223); plot(w,abs(H)); % Pintamos módulo 

%--------------------------------------
b= [1 0 0 0 0.1];
a=1;
fvtool(b,a,'fs',4400 );%3
