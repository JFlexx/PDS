function demo_serie(arg)

global  BASES ejes TXT pl punto y ORG current q NF L pos  AMP PH
global  A_last A_now

if nargin==0, arg='inicio'; end


switch(arg)
    
    case 'txt_current'      
        
%       if A_now*A_last<0,
%         %AMP(current)=-AMP(current);  
%         PH(current)=PH(current)+pi;  
%       end

% size(A_now), current
      AMP(current)=(A_now);
      % PH(current)=rem(PH(current),2*pi)-pi;      
      msg=sprintf('Ck = %5.3f',AMP(current));
      %msg=sprintf('C= %5.3f\nPh= %+4.1f',AMP(current),PH(current));
      set(TXT(current),'String',msg);   

      
    case 'inicio'
        
        clear ejes
        figure;
        set(gcf,'Pos',[200 10 500 680],'MenuBar','None',...
            'Name','Serie de Fourier');
        
        NF=11; 
        ALTO=0.80/(NF); ALTO=ALTO/1.1;
        T=1; t=[-T/2:0.001:T/2]; L=length(t); c = (L+1)/2;
        w = 2*pi*[0:NF]/T; 
        k=[0:NF]; INI=exp(-(k/4).^2); INI(1)=0.5;
        PH=0*INI; %PH(INI<0)=pi; INI(INI<0)=-INI(INI<0);
        %INI = 8*sin(k*pi/8)./(k*pi); INI(1)=0.5;
        
        BASES=NaN*zeros(NF,L); %SG=NaN*zeros(1,NF); 
        
        suma=0;
        DX = 0.10; k=1;  DY=1-1.1*ALTO;  ANCHO=0.75;
        for k = 1:NF,
            ejes(k)=axes('Pos',[DX DY ANCHO ALTO],'ButtonDownFcn','');
            uicontrol('Style','Text','Units','Norm','Pos',[0.0 DY+0.35*ALTO 0.09 0.02],...
                      'String',sprintf('k = %2d',k-1),'FontWeight','Bold','FontSize',10);
        
            %msg=sprintf('C= %5.3f\nPh= %4.1f',AMP(current),PH(current));                  
            msg=sprintf('Ck = %5.3f',INI(k));
            %msg=sprintf('C = %5.3f\nPh = %+4.1f',INI(k),PH(k));
            TXT(k) = uicontrol('Style','Text','Units','Norm',...
                      'FontWeight','Bold','FontSize',10,...
                      'Pos',[0.86 DY+0.1*ALTO 0.14 0.7*ALTO],...
                      'HorizontalAlig','Left',...
                      'String',msg);      
            AMP(k)=INI(k); PH(k)=0.0;     
            
            y = cos(w(k)*t+PH(k));  suma=suma+INI(k)*y;
           
            plot([1 L],[0 0],'k:'); hold on;
            pl(k) = plot(INI(k)*y,'b','ButtonDownFcn','demo_serie pincha_fase',...
                   'USERDATA',k); 
                                
            BASES(k,:)=y; 
            %SG=sign(y(c)); if SG<0, BASES(k,:)=-y; end
                       
            punto(k)=plot(c,INI(k)*y(c),'ro','MarkerFaceCol','r','MarkerSize',4,...
              'ButtonDownFcn','demo_serie pincha_amp','UserData',k);
            hold off
            k=k+1;
            DY=DY-ALTO*1.15;
        end
        
        DY=DY-ALTO;
        uicontrol('Style','Text','Units','Norm','Pos',[0.0 DY+0.35*ALTO 0.09 0.02],...
                  'String','Suma','FontWeight','Bold','FontSize',10);
        ejes(NF+1)=axes('Pos',[DX 0.005 ANCHO 0.15]); 
        plot([1 L],[0 0],'k:'); hold on;
        pl(NF+1)=plot(suma,'b','LineWidth',2);
        hold off
        

        set(ejes,'Xtick',[],'YTick',[],'Ylim',[-1 1]*1.1,'Xlim',[1 L]);
        set(ejes(NF+1),'Ylim',[-2 4]); %,'Ytick',[-2:2:4]);
        
        
        
    case 'suma'
       suma=0; 
       for k=1:NF,
         suma = suma + get(pl(k),'Ydata');  
       end    
       set(pl(NF+1),'Ydata',suma);
        
        
    case 'pincha_fase'
      TOTAL_dx=0;
      pos=get(gca,'CurrentPoint'); ORG=(pos(1,1));     
      current=get(gcbo,'UserData');  
      y = get(gcbo,'Ydata'); 
      q=get(punto(current),'Xdata');     
      set(gcf,'WindowButtonUpFcn','demo_serie libera');
      set(gcf,'WindowButtonMotionFcn','demo_serie mueve_fase;');      
      
        
    case 'mueve_fase'        
      pos=get(gca,'CurrentPoint'); pos=pos(1,1); 
      %dx = pos-ORG,
      dx = round(pos-ORG);      
      set(punto(current),'Xdata',rem(q+dx,L)+1);

      
      
      if dx>=0,      
        data= [y(end-dx:end) y(1:end-dx-1)]; 
        set(pl(current),'Ydata', data);              
        fase=acos(2*((BASES(current,:)*data')/AMP(current))/(L+1));
        PH(current)=fase;
      else
        dx=-dx;       
        data=[y(dx:end) y(1:dx-1)]; 
        set(pl(current),'Ydata',data);    
        fase=acos(2*((BASES(current,:)*data')/AMP(current))/(L+1));
        PH(current)=-fase;
      end
      
      A_now=AMP(current);
         
      demo_serie suma 
   
      demo_serie txt_current    
      
            
 
   
     case 'libera'                         
      set(gcf,'WindowButtonMotionFcn','','WindowButtonUpFcn','');    
     % set(gcf,'WindowButtonMotionFcn','');    
      TOTAL_dx=round(pos-ORG);  
      
%        k = current-1,      
%        if (k>0)
%          T=(L-1)/k,  
%          delta_ph = TOTAL_dx / T;
%          PH(current)=PH(current)+delta_ph;
%        end  
%        msg=sprintf('A = %4.2f\nF = %03.0fº',AMP(current),PH(current)*360);
%        set(TXT(current),'String',msg);
      
     % fprintf('TOTAL_dx %.2f\n',TOTAL_dx);               
   
      if TOTAL_dx==0, return; end
   
   %   axes(ejes(current));  hold on; 
      b = BASES(current,:);  
    
      if TOTAL_dx>0,
        b = [b(end-TOTAL_dx:end) b(1:end-TOTAL_dx-1)];  
      else
        b =  [b(-TOTAL_dx:end) b(1:-TOTAL_dx-1)];   
      end    
      
      BASES(current,:) = b;
      TOTAL_dx=0; pos=0;
    
      %  temp=plot(b,'r'); hold off;  pause(2);  delete(temp)  
                      
    case 'pincha_amp'
      current=get(gcbo,'UserData');          
      set(gcf,'WindowButtonUpFcn','demo_serie libera_amp');
      set(gcf,'WindowButtonMotionFcn','demo_serie mueve_amp;');      
              
    case 'mueve_amp'              
      pos=get(gca,'CurrentPoint'); pos=pos(1,2);  
      %if (current>1 & pos<0), pos=0; end
      set(pl(current),'Ydata',BASES(current,:)*(pos));
      set(punto(current),'Ydata',pos);
      demo_serie suma;    
    
      A_now=pos;      
      demo_serie txt_current   

      
    case 'libera_amp'
      set(gcf,'WindowButtonMotionFcn','','WindowButtonUpFcn','');  
      z = get(punto(current),'Ydata');
      c = get(punto(current),'Xdata');
      change = sign(z)*sign(BASES(current,c));
      if change<0, 
         BASES(current,:)=BASES(current,:);                  
      end
      
      %if (z*AMP(current)<0), PH(current)=rem(PH(current)+pi,2*pi); end
      %fprintf('SG %d\n',change);
      
      
      pos=0;
            
 
       
end    



    
  
 
  