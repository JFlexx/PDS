function demo_IIR(arg)

global  x_txt bx_txt out_txt W next c
global  x bp M N a last_y ay_txt
global suma_bx_txt suma_ay_txt

if nargin==0, arg='start'; end


switch (arg)
    
  case 'start'
    
      N=24; M=5; W=30; W_label=75;
             
      
      x = floor(18*rand(1,N))-9;
      x(1:5)=0;
      x(end-4:end)=0;
      
      x = [0 0 0 0 0 4  -1  1 -5 -1  8  0  0 -5 -1  2  3 -2  -3  0 0 0 0 0 0 0 0 0 0];
      
      %b = floor(5*rand(1,M));
      %b=x([1:5]+7);
      b = [1 -2 5 -1 2];
      bp=fliplr(b);
      
          figure('Pos',[100 100 700 300],...
           'Name','Demo IIR filter'); %,'Menubar','none'); 
   
      a=[-1 1];  
      last_y=[0 0];
   
      DY=240; DX=250; 
 
    uicontrol('Style','text','Units','Pix','Pos',[20 DY+30 180 20],...
              'String','Señal de entrada x[n-k]','FontSize',12,...
              'FontWeight','Bold','HorizontalAlig','left');
    uicontrol('Style','text','Units','Pix','Pos',[DX+80 DY+30 80 20],...
              'String','Sistema','FontSize',12,'FontWeight','Bold');
          
    ff=uicontrol('Style','frame','Units','Pix','Pos',[DX+W+8 DY-220 5*W+12 250]);
    
    
    for k=1:N, x_txt(k)=uicontrol('Style','text'); end;
    set(x_txt,'Units','Pix','BackgroundCol',[1 0.2 0.2]);
    set(x_txt,'FontSize',12,'FontWeight','Bold','String','4');
    %'VerticalAlign','Center');
    
%    uicontrol('Style','text','Units','Pix','Pos',[DX DY W+5 20],...
%              'FontSize',12,'FontWeight','Bold','String','x=');
    DX=DX+W+10+4*(W+2);     
    for k=1:N, 
      set(x_txt(k),'Pos',[DX DY W 20],'String',sprintf('%d',x(k))); 
      DX=DX-W-2;
    end
    set(x_txt([[1:5] [N-4:N]]),'BackgroundCol',[1 0.5 0.5])
    
        
    for k=1:M, b_txt(k)=uicontrol('Style','text'); end;
    set(b_txt,'Units','Pix','BackgroundCol',[0.2 1 0.2]);
    set(b_txt,'FontSize',12,'FontWeight','Bold','String','4');
    
    DY=DY-30; DX=250;     
    uicontrol('Style','text','Units','Pix','Pos',[DX-W_label+10 DY W_label+20 20],...
              'FontSize',12,'FontWeight','Bold','HorizontalAlig','Right',...
              'String','b(k)');
    
    DX=DX+W+10;     
    for k=1:M, 
      set(b_txt(k),'Pos',[DX DY W 20],'String',sprintf('%d',b(k))); 
      DX=DX+W+2;
    end
      
    
    for k=1:M, bx_txt(k)=uicontrol('Style','text'); end;
    set(bx_txt,'Units','Pix','BackgroundCol',[0.5 0.5 1]);
    set(bx_txt,'FontSize',12,'FontWeight','Bold','String','4');
    
    DY=DY-30; DX=250;     
    uicontrol('Style','text','Units','Pix','Pos',[DX-W_label+10 DY W_label+20 20],...
              'FontSize',12,'FontWeight','Bold','HorizontalAlig','Right',...
              'String','b(k)·x(n-k)');
    DX=DX+W+10;     
    S=0;
    for k=M:-1:1, 
      set(bx_txt(k),'Pos',[DX DY W 20],'String',sprintf('%d',bp(k)*x(k))); 
      DX=DX+W+2;
      S=S+bp(k)*x(k);
    end
    
    
    uicontrol('Style','frame','Units','Pix','Pos',[349    25    36   147]); 
    
    rg=[1:5]; 
    for k=1:N-2, 
        if k<3, c(k)=0; else c(k)=sum(x(rg).*bp); rg=rg+1; end
        out_txt(k)=uicontrol('Style','text','Visible','off');
        set(out_txt(k),'String',sprintf('%d',c(k)));     
    end;
    
    set(out_txt,'Units','Pix','BackgroundCol',[0.5 1 1]);
    set(out_txt,'FontSize',12,'FontWeight','Bold');
    
    
    DY=DY-90; DX=250;     
%     uicontrol('Style','text','Units','Pix','Pos',[DX DY W+5 20],...
%               'FontSize',12,'FontWeight','Bold','String','c =');
    
    DX=DX+W+10+4*(W+2)-2*(W+2);          
    %DX=DX+W+10+2*(W+2);     
 
    [DX DY-65 26 145]
    
    %    
    uicontrol('Style','text','Units','Pix','Pos',[DX-85 DY+60 75 20],...
              'String',['sum(b·x)'],'FontSize',10,'FontWeight','Bold',...
             'HorizontalAlig','left');
         
    suma_bx_txt= uicontrol('Style','text','Units','Pix','Pos',[DX-1 DY+60 30 20],...
              'String','0','FontSize',12,'FontWeight','Bold',...
               'HorizontalAlig','right');    

    uicontrol('Style','text','Units','Pix','Pos',[DX-85 DY+38 75 20],...
              'String',['-sum(a·y)'],'FontSize',10,'FontWeight','Bold',...
             'HorizontalAlig','left');      
    suma_ay_txt= uicontrol('Style','text','Units','Pix','Pos',[DX-1 DY+38 30 20],...
              'String','0','FontSize',12,'FontWeight','Bold',...
               'HorizontalAlig','right'); %,'BackgroundCol',[0.5 0.5 1]);            

       
           
%     
%     uicontrol('Style','Pushbutton','Units','Pix','Pos',[DX-260 DY 40 20],...
%               'FontSize',12,'FontWeight','Bold','HorizontalAlig','Right',...
%               'String','n - -','Callback','demo_IIR prev','UserData',1); 
    
    next=uicontrol('Style','Pushbutton','Units','Pix','Pos',[DX+120 DY+115 40 25],...
              'FontSize',12,'FontWeight','Bold','HorizontalAlig','Right',...
              'String','n++','Callback','demo_IIR next','UserData',1); 
          
    uicontrol('Style','text','Units','Pix','Pos',[DX-170 DY-62 160 25],...
              'FontSize',12,'FontWeight','Bold','HorizontalAlig','Right',...
              'String','Señal salida y(n)');    
    
    DX=DX+2*W+2;      
    for k=1:N-2,         
      set(out_txt(k),'Pos',[DX DY-60 W 20 ]); 
      DX=DX-W-2;
    end    
    set(out_txt(1:3),'Visible','on');  
   
    
    for k=1:2, 
      a_txt(k)=uicontrol('Style','text'); ay_txt(k)=uicontrol('Style','text');
    end;
    set([a_txt ay_txt],'Units','Pix','BackgroundCol',[0.2 1 0.3]);
    set([a_txt ay_txt],'FontSize',12,'FontWeight','Bold','String','4');
    set(ay_txt,'BackgroundCol',[1 1 0]); %[0.2 0.3 1]);
    
    DY=DY-30; DX=356+W;     
    for k=1:2, 
        set(a_txt(k),'Pos',[DX DY W 20],'String',sprintf('%d',a(k))); 
        set(ay_txt(k),'Pos',[DX DY+30 W 20],'String',sprintf('%d',a(k)*last_y(k))); 
        DX=DX+W+2; 
    end   
    
    uicontrol('Style','text','Units','Pix','Pos',[DX+5 DY-2 W_label 25],...
              'FontSize',12,'FontWeight','Bold','HorizontalAlig','Left',...
              'String','a(k)');
          
    uicontrol('Style','text','Units','Pix','Pos',[DX+5 DY+28 W_label+20 25],...
              'FontSize',12,'FontWeight','Bold','HorizontalAlig','Left',...
              'String','a(k)·y(n-k)');
          
    
    return
    
    
    case 'prev'
        
     k=get(next,'UserData'); if(k==1), return; end

     set(next,'Userdata',k-1);  
     set(out_txt(k),'Visible','off');     
     %k=get(gcbo,'UserData');
     %if (k==N-4) return; end;
     %set(gcbo,'Userdata',k+1);   
           
                
      for i=1:N,
        p = get(x_txt(i),'Pos'); p = p - [W+2 0 0 0]; set(x_txt(i),'Pos',p);
      end
           
      xrg=x([1:5]+k-2);  
      for i=M:-1:1, 
        pp=bp(i)*xrg(i);  
        set(bx_txt(i),'String',sprintf('%d',pp)); 
      end
      
      for i=1:N-4
        p = get(out_txt(i),'Pos'); p = p - [W+2 0 0 0]; set(out_txt(i),'Pos',p);                                 
      end
       
     
    
    
    case 'next'
        
     k=get(gcbo,'UserData');
     if (k==N-4) return; end;
     
     set(gcbo,'Userdata',k+1);   
        
     %k=get(gcbo,'UserData');
     %if (k<N-5), set(gcbo,'Userdata',k+1); end    
                
      for i=1:N,  % Mover casillas x[]
        p = get(x_txt(i),'Pos'); p = p + [W+2 0 0 0]; set(x_txt(i),'Pos',p);
      end
      
      suma_bx=0;
      bp;  
      xrg=x([1:5]+k);
      for i=M:-1:1, 
        pp=bp(i)*xrg(i);   suma_bx=suma_bx+pp;
        set(bx_txt(i),'String',sprintf('%d',pp)); 
      end
      
      
      
      for i=1:N-2 % Mueve salida
        p = get(out_txt(i),'Pos'); p = p + [W+2 0 0 0]; set(out_txt(i),'Pos',p);                                 
      end
      
       for i=1:2
          set(ay_txt(i),'String',sprintf('%d',a(i)*last_y(i)));                                 
       end       
       
       recursion = -sum(a.*last_y);
      
       
       set(suma_bx_txt,'String',sprintf('%d',suma_bx));
       set(suma_ay_txt,'String',sprintf('%d',recursion));
       
       res = suma_bx+recursion;
      
       last_y=[res last_y(1)];
      
      set(out_txt(k+3),'Visible','on','String',sprintf('%d',res));  
    
end    