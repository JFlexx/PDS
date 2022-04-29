close all, clear all

[x fs]=audioread('vozam1.wav');
%sound(x,fs)

b=[1 -1.7213 1];%x
a=[1 -1.6352 0.9025];%y


y= filtro_IIR(b,a,x);
y2 =filter(b,a,x);

%sound(y,fs)
show2(x,y,fs) 