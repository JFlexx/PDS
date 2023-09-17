function show_IQ(I,Q)

L=length(I);  n = 10; % Num de puntos simultaneos

figure('Position',[200 200 400 450],'Menubar','None',...
       'Name','Osciloscopio IQ'); 

plot(0.5,0,'sb','MarkerSize',15); hold on
plot(-0.5,0,'sb','MarkerSize',15);
pl(1)=plot(NaN,NaN,'ro','MarkerSize',3,'MarkerFaceColor','r'); 
pl(2)=plot(NaN*ones(1,n),NaN*ones(1,n),'r');
hold off 
set(gca,'Xlim',[-1 1],'Ylim',[-1 1]);
axis equal

for k=1:n:L-n, 
    rg=k+(0:n-1);
    set(pl(1),'Xdata',I(rg(end)),'Ydata',Q(rg(end)));
    set(pl(2),'Xdata',I(rg),'Ydata',Q(rg)); 
    set(gca,'Xlim',[-1 1],'Ylim',[-1 1]);
    drawnow(); pause(0.001); 
end