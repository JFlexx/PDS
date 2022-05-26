function sist_dif(arg,arg2)

global f0 fs AMP FASE dt A B Nc TXT Na Nb
global out AB_txt

delay=0.001;

if nargin==0, arg='inicio'; B=[0.5 -0.5]; A=1; end


if nargin==2, B=arg; A=arg2; arg='inicio'; end


switch(arg)
    
    case 'frec'
      v=get(gcbo,'Value');
      f0=v; Nc = fs/f0;
      sist_dif pinta
%      fprintf('Frec %.0f . Gain %.2f . Fase %.2f\n',f0,1/AMP,2*pi*FASE/Nc);
    
    case 'amp'
      v=get(gcbo,'Value');
      AMP=10^v;
      sist_dif pinta
%   fprintf('Frec %.0f . Gain %.2f . Fase %.2f\n',f0,1/AMP,2*pi*FASE/Nc);
            
    case 'phase'
      v=get(gcbo,'Value');
      FASE=round(v); 
      sist_dif pinta
%      fprintf('Frec %.0f . Gain %.2f . Fase %.2f\n',f0,1/AMP,2*pi*FASE/Nc);

    case 'pinta'
       gain = AMP; ph=FASE/Nc;  
       
       ph=mod(ph+0.5,1)-0.5;
       
     
       %wn=f0/(fs/2);    
       msg=sprintf('Frec=%4.0f Hz. Compensación aplicada -> GANANCIA: x %.1f (%.1f dB). PHASE: %.2f rads (%.0fº)',...
                    f0,gain,20*log10(gain),2*pi*ph,ph*360);  
      % fprintf('%s\n',msg);         
       set(TXT,'String',msg); 
           
    case 'cambia_a'
        old = A;
        st = get(gcbo,'String'); 
        A = sscanf(st,'%f');
        if isempty(A), A = old; end
        set(gcbo,'String',sprintf('%4.2f ',A));
        Na=length(A);
    
    case 'cambia_b'
        old = B;
        st = get(gcbo,'String'); 
        B = sscanf(st,'%f');
        if isempty(B), B = old; end
        set(gcbo,'String',sprintf('%4.2f ',B));        
        Nb=length(B);
        
    case 'salir'
        out=1;
        pause(0.1);
        delete(gcf);
        
    case 'load_ab'
        fich=uigetfile('AB_*.mat');
        if fich==0, return; end
        
        load(fich); 
        Na=length(A);
        set(AB_txt(2),'String',sprintf('%4.2f ',A));
        set(AB_txt(1),'String',sprintf('%4.2f ',B));        
        Nb=length(B);
        
    case 'inicio'
 
    out=0;    
        
    f0=100; fs=40000; dt=1/fs;    
   
    N=100000; x = zeros(1,N); y=zeros(1,N); fase=0; 

    AMP=1; FASE=0;

    %B=[1]; A=[1];
    Nb=length(B);
    Na=length(A);
    
    SHOW=400; DELTA=0;
    

    ALTO=500;
    pp=get(0,'ScreenSize');   pp=pp(3:4);
    figure(13); set(gcf,'Pos',[50 pp(2)-50-ALTO pp(1)-100 ALTO],'MenuBar','None'); %,'Number','off');
    set(gcf,'CloseRequestFcn','sist_dif salir', ...
            'Name','Sist de ecuaciones en diferencias (Antonio Tabernero)'); 
    
    uicontrol('Style','Text','Units','Norm','Pos',[0.01 0.95 0.03 0.035],'String','b(k)',...
              'FontSize',10,'Fontweight','Bold','HorizontalAl','Left','FontName','Courier');
    
    AB_txt(1)=uicontrol('Style','Edit','Units','Norm','Pos',[0.042 0.945 0.46 0.04],...
              'FontName','Courier','String',sprintf('%4.2f ',B),...
              'FontSize',10,'Fontweight','Bold','HorizontalAl','Left',...
              'Callback','sist_dif cambia_b');
          
    uicontrol('Style','Text','Units','Norm','Pos',[0.52 0.95 0.03 0.035],'String','a(k)',...
              'FontSize',10,'Fontweight','Bold','HorizontalAl','Left','FontName','Courier');
    
    AB_txt(2)=uicontrol('Style','Edit','Units','Norm','Pos',[0.555 0.945 0.40 0.04],...
              'FontName','Courier','String',sprintf('%4.2f ',A),...
              'FontSize',10,'Fontweight','Bold','HorizontalAl','Left',...
              'Callback','sist_dif cambia_a'); 
    
%      uicontrol('Style','Push','Units','Norm','Pos',[0.91 0.95 0.08 0.035],...
%                'FontSize',10,'Fontweight','Bold','String','Load A/B',...
%                'Callback','sist_dif load_ab');
          
    rg_x=(1:2*SHOW);
    rg_y=(SHOW+1:2*SHOW);
    
    rg_xx=(SHOW+1:2*SHOW);
    
    axes('Pos',[0.04 0.52 0.92 0.4]);
    
    pl_1=plot((-SHOW:-1),x(rg_xx),'b'); hold on
    pl_2=plot(DELTA+(0:SHOW-1),y(rg_y),'g');
    plot([0 0],1.5*[-1 1],'g','LineWidth',2);
    hold off
    
    set(gca,'Xtick',[]);
    
    axes('Pos',[0.04 0.08 0.92 0.40]);
    
    pl_x=plot((-SHOW:SHOW-1),x(rg_x),'b'); hold on
    %pl_y=plot(DELTA+(0:SHOW-1),y(rg_y),'g');
    pl_Y=plot(DELTA+(0:SHOW-1),y(rg_y),'r');
   
    
    plot([0 0],1.5*[-1 1],'g','LineWidth',2);
    
    plot([DELTA SHOW+DELTA],[0 0],'k:');    
    hold off
    set(gca,'Xtick',[]);

  
    
    Nc = fs/f0;

    %uicontrol('Style','Text','Units','Norm','Pos',[0.05 0.87 0.06 0.04],'String','Frec',...
    %          'FontSize',12,'Fontweight','Bold','HorizontalAl','Left','FontName','Courier');    
%     uicontrol('Style','slider','Units','Norm','Pos',[0.12 0.87 0.20 0.04],...
%               'Min',0,'Max',fs/10,'Value',f0,'SliderStep',[1 10]/(fs/10),...
%               'CallBack','sist_dif frec');
    
    uicontrol('Style','Text','Units','Norm','Pos',[0.51 0.085 0.04 0.04],'String','Fase',...
              'FontSize',12,'Fontweight','Bold','HorizontalAl','Left','FontName','Courier');           
    uicontrol('Style','slider','Units','Norm','Pos',[0.55 0.09 0.17 0.035],...
              'Min',-Nc,'Max',Nc,'Value',0,'SliderStep',[1 2]/(2*Nc),...
              'CallBack','sist_dif phase');
          
    uicontrol('Style','Text','Units','Norm','Pos',[0.74 0.085 0.03 0.04],'String','Amp',...
              'FontSize',12,'Fontweight','Bold','HorizontalAl','Left','FontName','Courier');           
    uicontrol('Style','slider','Units','Norm','Pos',[0.77 0.09 0.17 0.035],...
              'Min',-5,'Max',5,'Value',0,'SliderStep',[0.001 0.05],...
              'CallBack','sist_dif amp');
          
%    uicontrol('Style','Text','Units','Norm','Pos',[0.965 0.08 0.03 0.04],'String','Amp',...
%               'FontSize',12,'Fontweight','Bold','HorizontalAl','Left');        
%     uicontrol('Style','slider','Units','Norm','Pos',[0.965 0.13 0.015 0.35],...
%               'Min',-2,'Max',2,'Value',0,'SliderStep',[0.001 0.05],...
%               'CallBack','sist_dif amp');

    uicontrol('Style','slider','Units','Norm','Pos',[0.04 0.015 0.15 0.035],...
               'Min',0,'Max',fs/10,'Value',f0,'SliderStep',[1 10]/(fs/10),...
               'CallBack','sist_dif frec');          
    TXT=uicontrol('Style','Text','Units','Norm','Pos',[0.20 0.01 0.78 0.04],...
                  'FontSize',12,'FontWeight','Bold','HorizontalAl','Left','String','QQQ'); 
     
    sist_dif pinta          

    rg_x=(1:2*SHOW);
    rg_y=(SHOW+1:2*SHOW)-SHOW;
    
    for k=SHOW+1:N
     
      if (out), break; end  
        
      fase = fase+2*pi*f0*dt;           
      x(k)=sin(fase);
      
       temp=0; %-0.95*x(k-1);;
       for n=0:Nb-1, temp=temp+B(n+1)*x(k-n); end
       for n=1:Na-1, temp=temp-A(n+1)*y(k-n); end      
       y(k) = temp/A(1);
%       
       rg_xx=rg_xx+1;
       rg_x=rg_x+1;
       rg_y=rg_y+1; 
       
       if(rg_x(1)-SHOW<1), continue; end
       

       set(pl_1,'Ydata',fliplr(x(rg_xx-SHOW))); 
       set(pl_2,'Ydata',y(fliplr(rg_y-SHOW)));
       
       set(pl_x,'Ydata',fliplr(x(rg_x-SHOW))); 
      % set(pl_y,'Ydata',y(fliplr(rg_y-SHOW)));
       set(pl_Y,'Ydata',AMP*y(fliplr(rg_y+FASE-SHOW)));
       set(gca,'Ylim',1.5*[-1 1],'Xlim',[-SHOW DELTA+SHOW]);
       drawnow;
       pause(delay);
    
%       if rem(rg_x(1),10)==0,
%         Ay=max(y(rg_y)); 
%         p = mean(2*x(rg_y).*y(rg_y)/Ay); if abs(p)>1, p=sign(p); end 
%         fprintf('Gain %4.2f Delta Phase %5.2f\n',Ay,acos(p)/pi)    
%       end    
  
    end    
    
 
end




