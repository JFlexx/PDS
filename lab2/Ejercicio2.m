clear all, close all

load coeficientes.mat
N=20;
f0= 180;%Hz

a0=0; fs =44100; t=(0:1/fs:0.5)';

%%%bucle
for i=1:5
    a=A(i,:);
    b=B(i,:);

    x=a0;
    for k= 1:20
        x= x + a.*cos(2*pi*(k*f0)*t) + b.*sin(2*pi*(k*f0)*t);
                plot(t,x )

        %sound(x(:,k), fs)
    end
    
end

%%%escuchar x
w=tukeywin(length(x)); 
x=x.*w;
for k= 1:20
    sound(x(:,k), fs)
    pause(0.5)
end


