function show_h(arg,arg2)

global TXT A  B Na Nb  
global tipo P Nc
global XX cont L AB_txt
global exit
global x y temp

if nargin==0, arg='inicio'; end


if nargin==2, B=arg; A=arg2; arg='inicio'; end


switch(arg)
    
    case 'load_ab'
        fich=uigetfile('AB_*.mat');
        if fich==0, return; end
        
        load(fich); 
        Na=length(A);
        set(AB_txt(2),'String',sprintf('%4.2f ',A));
        set(AB_txt(1),'String',sprintf('%4.2f ',B));        
        Nb=length(B);
        
    case 'cambia_a'
        old = A;
        st = get(gcbo,'String'); 
        A = sscanf(st,'%f');
        if isempty(A), A = old; end       
        Na=length(A);
        set(AB_txt(2),'String',sprintf('%4.2f ',A));
        %set(gcbo,'String',sprintf('%4.2f ',A));
     
    case 'cambia_b'
        old = B;
        st = get(gcbo,'String'); 
        B = sscanf(st,'%f');
        if isempty(B), B = old; end
        set(AB_txt(1),'String',sprintf('%4.2f ',B)); 
        %set(gcbo,'String',sprintf('%4.2f ',B));        
        Nb=length(B);
    
    case 'pause'
        st=get(gcbo,'String');
        if strcmp(st,'Pause'),
           set(gcbo,'String','Resume');
           uiwait;
        else
           set(gcbo,'String','Pause');
           uiresume;            
        end
        
    case 'shot'
        tipo=1; P=1;
    case 'tren'
        tipo=2; P=0;
    case 'zero'
        tipo=0; 
    case 'sin'
        tipo=3; 
    case 'step'
        tipo=5;       
    case 'pulso'       
        n=[-200:200]/Nc;
        XX=exp(-n.^2); L = length(XX); cont=1;
        tipo=4;
        
    case 'signal'        
        fich=uigetfile('X*.mat');
        if fich==0, return; end
        
        load(fich); XX=x; cont=1; L = length(XX);
        tipo=4;
        
    case 'salir'
      exit=1;
      pause(0.1);
      delete(gcf); 
        
    case 'reset'
       temp=0;
       y=0*y;
       x=0*x;
       
    case 'inicio'

   
    exit=0;    
    tipo=0; P=0; Nc=40;
    N=100000; x = zeros(1,N); y=zeros(1,N); fase=0; 

    if nargin==0, B=[1]; A=[1]; Nb=length(B);Na=length(A); end
    
    
    SHOW=200; DELTA=0;
    
    screen=get(0,'ScreenSize');
    figure(1); 
    ALTO=350;
    set(gcf,'Pos',[25  (screen(4)-ALTO)/2 screen(3)-50 ALTO],'MenuBar','None',...
          'CloseRequestFcn','show_h salir', ...
          'Name','Sistemas en diferencias (Antonio Tabernero)');  
    
    rg_x=[1:2*SHOW];
    rg_y=[SHOW+1:2*SHOW];
    
    rg_xx=[SHOW+1:2*SHOW];
    
    
    pl_1=stem([-SHOW:-1],x(rg_xx),'b','MarkerSize',2,'MarkerFaceColor','b'); hold on
    pl_2=stem(DELTA+[0:SHOW-1],y(rg_y),'g','MarkerSize',2,'MarkerFaceColor','g');
    plot([0 0],5*[-1 1],'g','LineWidth',2);
    hold off
    
    set(gca,'Xtick',[],'Ytick',[-1 0 1],'Ylim',2*[-1 1]);
    set(gca,'Pos',[0.13 0.03 0.86 0.81]);
      

    uicontrol('Style','Push','Units','Norm','Pos',[0.01 0.91 0.1 0.06],'String','Load A,B',...
              'FontSize',12,'Fontweight','Bold','HorizontalAl','Left','FontName','Courier',...
              'Callback','show_h load_ab');
    
    uicontrol('Style','Text','Units','Norm','Pos',[0.13 0.91 0.035 0.06],'String','b(k)',...
              'FontSize',12,'Fontweight','Bold','HorizontalAl','Left','FontName','Courier');
    
    AB_txt(1)=uicontrol('Style','Edit','Units','Norm','Pos',[0.165 0.91 0.38 0.06],...
              'FontName','Courier','String',sprintf('%4.2f ',B),...
              'FontSize',10,'Fontweight','Bold','HorizontalAl','Left',...
              'Callback','show_h cambia_b');
          
    uicontrol('Style','Text','Units','Norm','Pos',[0.57 0.91 0.035 0.06],'String','a(k)',...
              'FontSize',12,'Fontweight','Bold','HorizontalAl','Left','FontName','Courier');
    
    AB_txt(2)=uicontrol('Style','Edit','Units','Norm','Pos',[0.605 0.91 0.375 0.06],...
              'FontName','Courier','String',sprintf('%4.2f ',A),...
              'FontSize',10,'Fontweight','Bold','HorizontalAl','Left',...
              'Callback','show_h cambia_a');          

    TXT(1) =  uicontrol('Style','Text','String','x[n] = 0.0',...
              'Units','Norm','Pos',[0.135 0.03 0.25 0.06],'BackgroundCol',[1 1 1]);
                   
    TXT(2) =  uicontrol('Style','Text','String','y[n] = 0.0',...
              'Units','Norm','Pos',[0.565 0.03 0.25 0.06],'BackgroundCol',[1 1 1]);
              
    set(TXT,'FontSize',12,'Fontweight','Bold','HorizontalAl','Left','FontName','Courier');      
   
%     uicontrol('Style','slider','Units','Norm','Pos',[0.60 0.06 0.20 0.05],...
%               'Min',-Nc,'Max',Nc,'Value',0,'SliderStep',[1 2]/(2*Nc),...
%               'CallBack','show_h phase');
%           
%     uicontrol('Style','slider','Units','Norm','Pos',[0.93 0.30 0.025 0.40],...
%               'Min',-2,'Max',2,'Value',0,'SliderStep',[0.001 0.05],...
%               'CallBack','show_h amp');
%    

    

    DY=0.70; AY=0.06; SY=0.09;
    
    uicontrol('Style','Frame','Units','Norm','Pos',[0.01 DY-0.49 0.10 0.60]);
    uicontrol('Style','Text','Units','Norm','Pos',[0.02 DY+0.08 0.06 0.05],...
        'String','Input Signal','FontWeight','Bold');
    
    uicontrol('Style','Pushbutton','Units','Norm','Pos',[0.02 DY 0.06 AY],...
              'String','Impulso','Callback','show_h shot');
    DY=DY-SY;          
%     uicontrol('Style','Pushbutton','Units','Norm','Pos',[0.02 DY 0.06 AY],...
%               'String','Pulso','Callback','show_h pulso');
%     DY=DY-SY;          
        
    uicontrol('Style','Pushbutton','Units','Norm','Pos',[0.02 DY 0.06 AY],...
              'String','Step','Callback','show_h step');
        DY=DY-SY;           
    uicontrol('Style','Pushbutton','Units','Norm','Pos',[0.02 DY 0.06 AY],...
              'String','Zero','Callback','show_h zero');
        DY=DY-SY-0.01;           
    
    uicontrol('Style','Pushbutton','Units','Norm','Pos',[0.02 DY 0.06 AY],...
              'String','Tren','Callback','show_h tren');          
        DY=DY-SY;           
    uicontrol('Style','Pushbutton','Units','Norm','Pos',[0.02 DY 0.06 AY],...
              'String','Sin','Callback','show_h sin');
    %     DY=DY-SY;          
    uicontrol('Style','slider','Units','Norm','Pos',[0.09 DY 0.01,AY+SY],...
               'Min',2,'Max',202,'Value',Nc,'SliderStep',[1 10]/200,...
               'CallBack','show_h frec');     
    
    DY=DY-SY-0.01;      
    uicontrol('Style','Pushbutton','Units','Norm','Pos',[0.02 DY 0.06 AY],...
              'String','Load','Callback','show_h signal');
          
          
    uicontrol('Style','Pushbutton','Units','Norm','Pos',[0.01 0.03 0.04 AY],...
              'String','Pause','Callback','show_h pause');
    uicontrol('Style','Pushbutton','Units','Norm','Pos',[0.06 0.03 0.04 AY],...
              'String','Reset','Callback','show_h reset');
          
    rg_x=[1:2*SHOW];
    rg_y=[SHOW+1:2*SHOW]-SHOW;
    
    fase=0;
    for k=SHOW+1:N,           
           
       switch tipo,

           case 0,  % zero
             x(k)=0; 
           
           case 1,  % Delta[n]
            if P==1, x(k)=1; P=0; else x(k)=0; end     
           
           case 2,  % Tren deltas
            if rem(k,Nc)==0, x(k)=1; else x(k)=0; end; 
            
           case 3,
             fase = fase+2*pi/Nc;  x(k)=cos(fase);        
             
           case 4, 
             x(k) = XX(cont); cont=rem(cont,L)+1; 
             
           case 5,
             x(k)=1;
             
       end    
      

       temp=0; %-0.95*x(k-1);;      
       for n=0:Nb-1, temp=temp+B(n+1)*x(k-n); end
       for n=1:Na-1, temp=temp-A(n+1)*y(k-n); end    
       temp=temp/A(1);
     
%        fprintf('B %.1f %.1f %.1f  A %.1f\n',B,A(2:end));
%        fprintf('X %.1f %.1f %.1f  Y %.1f -> %f\n',x([k:-1:k-2]),y(k-1),temp);
      
       y(k) = temp;
%       

       set(TXT(1),'String',sprintf('x[n] = %9.6f',x(k-SHOW)));
       set(TXT(2),'String',sprintf('y[n] = %9.6f',y(k-SHOW)));

       rg_xx=rg_xx+1;
       rg_x=rg_x+1;
       rg_y=rg_y+1; 
       
       if(rg_x(1)-SHOW<1), continue; end
       

       set(pl_1,'Ydata',fliplr(x(rg_xx-SHOW))); 
       set(pl_2,'Ydata',y(fliplr(rg_y-SHOW)));
       
drawnow
      %  pause(0.01);
       
        if exit, break; end 

    end    
    
    
    case 'frec'
      v=get(gcbo,'Value');
      Nc = round(v);

end