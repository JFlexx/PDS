function demo_FIR(arg)

global  xx xy cc W next
global  x yp M N

if nargin==0, arg='start'; end


switch (arg)
    
  case 'start'
    
      N=24; M=5; W=30; W_label=75;
             
      
      x = floor(18*rand(1,N))-9;
      x(1:5)=0;
      x(end-4:end)=0;
      
      %y = floor(5*rand(1,M));
      %y=x([1:5]+7);
      y = [1 -2 5 -1 2];
      yp=fliplr(y);
      
          figure('Pos',[100 100 700 200],...
           'Name','Ilustración Filtrado FIR','Menubar','none'); 
   
   
    DY=140; DX=250; 
 
    uicontrol('Style','text','Units','Pix','Pos',[20 DY+30 180 20],...
              'String','Señal de entrada x[n-k]','FontSize',12,...
              'FontWeight','Bold','HorizontalAlig','left');
    uicontrol('Style','text','Units','Pix','Pos',[DX+80 DY+30 80 20],...
              'String','Sistema','FontSize',12,'FontWeight','Bold');
          
    ff=uicontrol('Style','frame','Units','Pix','Pos',[DX+W+8 DY-65 5*W+12 90]);
    
    
    for k=1:N, 
      xx(k)=uicontrol('Style','text','Units','pix',...
                      'BackgroundCol',[1 0.2 0.2],...
                      'FontSize',12,'FontWeight','Bold','String','4'); 
    end;
    %set(xx,);
    %set(xx,);
    %'VerticalAlign','Center');
    
%    uicontrol('Style','text','Units','Pix','Pos',[DX DY W+5 20],...
%              'FontSize',12,'FontWeight','Bold','String','x=');
    DX=DX+W+10+4*(W+2);     
    for k=1:N, 
      set(xx(k),'Pos',[DX DY W 20],'String',sprintf('%d',x(k))); 
      DX=DX-W-2;
    end
    set(xx([[1:5] [N-4:N]]),'BackgroundCol',[1 0.5 0.5])
    
        
    for k=1:M, yy(k)=uicontrol('Style','text'); end;
    set(yy,'Units','Pix','BackgroundCol',[0.2 1 0.2]);
    set(yy,'FontSize',12,'FontWeight','Bold','String','4');
    
    DY=DY-30; DX=250;     
    uicontrol('Style','text','Units','Pix','Pos',[DX-W_label+10 DY W_label+20 20],...
              'FontSize',12,'FontWeight','Bold','HorizontalAlig','Right',...
              'String','b(k)');
    
    DX=DX+W+10;     
    for k=1:M, 
      set(yy(k),'Pos',[DX DY W 20],'String',sprintf('%d',y(k))); 
      DX=DX+W+2;
    end
      
    
    for k=1:M, xy(k)=uicontrol('Style','text'); end;
    set(xy,'Units','Pix','BackgroundCol',[0.5 0.5 1]);
    set(xy,'FontSize',12,'FontWeight','Bold','String','4');
    
    DY=DY-30; DX=250;     
    uicontrol('Style','text','Units','Pix','Pos',[DX-W_label+10 DY W_label+20 20],...
              'FontSize',12,'FontWeight','Bold','HorizontalAlig','Right',...
              'String','b(k)·x(n-k)');
    DX=DX+W+10;     
    S=0;
    for k=M:-1:1, 
      set(xy(k),'Pos',[DX DY W 20],'String',sprintf('%d',yp(k)*x(k))); 
      DX=DX+W+2;
      S=S+yp(k)*x(k);
    end
    
    
    
    rg=[1:5]; 
    for k=1:N-4, 
        c(k) = sum(x(rg).*yp); rg=rg+1;
        cc(k)=uicontrol('Style','text','Visible','off');
        set(cc(k),'String',sprintf('%d',c(k)));     
    end;
    
    set(cc,'Units','Pix','BackgroundCol',[0.5 1 1]);
    set(cc,'FontSize',12,'FontWeight','Bold');
    
    
    DY=DY-50; DX=250;     
%     uicontrol('Style','text','Units','Pix','Pos',[DX DY W+5 20],...
%               'FontSize',12,'FontWeight','Bold','String','c =');
    
    DX=DX+W+10+4*(W+2)-2*(W+2);          
    %DX=DX+W+10+2*(W+2);     
    
    suma=uicontrol('Style','text','Units','Pix','Pos',[DX-8 DY+25 45 20]);
    set(suma,'String','Suma','FontSize',10,'FontWeight','Bold');

    
    uicontrol('Style','Pushbutton','Units','Pix','Pos',[DX-290 DY 45 25],...
              'FontSize',12,'FontWeight','Bold','HorizontalAlig','Right',...
              'String','n - -','Callback','demo_FIR prev','UserData',1); 
    
    next=uicontrol('Style','Pushbutton','Units','Pix','Pos',[DX-230 DY 45 25],...
              'FontSize',12,'FontWeight','Bold','HorizontalAlig','Right',...
              'String','n++','Callback','demo_FIR next','UserData',1); 
          
    uicontrol('Style','text','Units','Pix','Pos',[DX-175 DY-2 165 25],...
              'FontSize',12,'FontWeight','Bold','HorizontalAlig','Left',...
              'String','Señal salida y(n)');    
    for k=1:N-4,         
      set(cc(k),'Pos',[DX DY W 20 ]); 
      DX=DX-W-2;
    end
    
     set(cc(1),'Visible','on');  
   
    return
    
    
    case 'prev'
        
     k=get(next,'UserData'); if(k==1), return; end

     set(next,'Userdata',k-1);  
     set(cc(k),'Visible','off');     
     %k=get(gcbo,'UserData');
     %if (k==N-4) return; end;
     %set(gcbo,'Userdata',k+1);   
           
                
      for i=1:N,
        p = get(xx(i),'Pos'); p = p - [W+2 0 0 0]; set(xx(i),'Pos',p);
      end
           
      xrg=x([1:5]+k-2);
      for i=M:-1:1, 
        pp=yp(i)*xrg(i);  
        set(xy(i),'String',sprintf('%d',pp)); 
      end
      
      for i=1:N-4
        p = get(cc(i),'Pos'); p = p - [W+2 0 0 0]; set(cc(i),'Pos',p);                                 
      end
       
     
    
    
    case 'next'
        
     k=get(gcbo,'UserData');
     if (k==N-4) return; end;
     
     set(gcbo,'Userdata',k+1);   
        
     %k=get(gcbo,'UserData');
     %if (k<N-5), set(gcbo,'Userdata',k+1); end    
                
      for i=1:N,
        p = get(xx(i),'Pos'); p = p + [W+2 0 0 0]; set(xx(i),'Pos',p);
      end
      
      yp;
      xrg=x([1:5]+k);
      for i=M:-1:1, 
        pp=yp(i)*xrg(i);  
        set(xy(i),'String',sprintf('%d',pp)); 
      end
      
      for i=1:N-4
        p = get(cc(i),'Pos'); p = p + [W+2 0 0 0]; set(cc(i),'Pos',p);                                 
      end
       
     set(cc(k+1),'Visible','on');  
    
end    