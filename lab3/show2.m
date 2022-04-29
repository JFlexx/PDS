function show2(x,y,fs,forma)
% Muestra dos señales x[] e y[] muestreadas a fs Hz 
% simultaneamente en dos ventanas, con un slider para 
% desplazarnos en el tiempo

% Feb2012, Antonio Tabernero Galán


if nargin,
   
  if nargin==2, fs=100000; forma='superpuesto'; end
  if nargin==3, forma='superpuesto'; end
   
  L=min([100000 length(x) length(y)]);
  x=x(1:L); y=y(1:L);
  
  m=min(min(x),min(y));
  M=max(max(x),max(y));  
  %m=m-0.05*(M-m); M=M+0.05*(M-m);
  rangoy=[m M];
  
  t=1000*[0:L-1]/fs;    % Tiempo en msec
  
  T=16;
  %if (fs<10000) T=16; else T=4; end
  maxt=t(L)-T;  

  figure('Position',[50 200 750 360], ... %'MenuBar','none',...
         'Name','Mostrar dos señales');
  
  barra=uicontrol('Style','Slider','Units','Normalized');
  set(barra,'Position',[0.10 0.94 0.85 0.05],'Min',0,'Max',maxt);
  set(barra,'Value',0,'callback','show2','UserData',[T m M]); 
  step=T/t(L);
  set(barra,'SliderStep',[step/2 4*step]);
  
  ini=get(barra,'Value');
  intervalo=[ini ini+T];
  
  if strcmp(forma,'superpuesto'),
    subplot('Position',[0.1 0.1 0.85 0.82]);
    plot(t,x,'r',t,y,'b'); set(gca,'Xlim',intervalo,'Ylim',rangoy); 
    xlabel('Tiempo (msec)');   
  else    
    subplot('Position',[0.1 0.1 0.85 0.4]);
    plot(t,x,'r'); set(gca,'Xlim',intervalo,'Ylim',rangoy); 
    xlabel('Tiempo (msec)');
  
    subplot('Position',[0.1 0.52 0.85 0.4]);
    plot(t,y,'b'); set(gca,'Xlim',intervalo,'Ylim',rangoy,'Xtick',[]);
  end
  
  
else
   data=get(gcbo,'UserData');
   T=data(1); rangoy=data(2:3);
   ini=get(gcbo,'Value'); 
   intervalo=round([ini ini+T]);
   ejes=findobj(gcf,'Type','axes');
   
   set(ejes,'Xlim',intervalo,'Ylim',rangoy); 
 end   