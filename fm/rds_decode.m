function rds_decode(data)

global type_names pty_list radio_text program_name

check=[512  256  128   64   32   16    8    4    2    1  732  366  183 ...
       647  927  787  853  886  443  513  988  494  247  679  911  795];
   
offset=[  984   980   604   972   600];


radio_text=char(ones(1,64)*35);
program_name=char(ones(1,8)*35);


%generate_rds_info;


type_names = {...
'Basic tuning and switching information', 'Basic tuning and switching information'; ...
'Program Item Number and slow labeling codes','Program Item Number'; ...
'Radiotext','Radiotext';...
'Applications Identification for ODA','Open Data Applications'; ...
'Clock-time and date only','Open Data Applications';...
'Transparent Data Channels (32 channels) or ODA','Transparent Data Channels (32 channels) or ODA';...
'In House applications or ODA','In House applications or ODA'; ...
'Radio Paging or ODA','Open Data Applications'; ...
'Traffic Message Channel (TMC) or ODA','Open Data Applications'; ...
'Emergency Warning System (EWS)or ODA','Open Data Applications';...
'Program Type Name','Open Data Applications';...
'Open Data Applications','Open Data Applications';...
'Open Data Applications','Open Data Applications';...
'Enhanced Radio Paging or ODA','Open Data Applications';...
'Enhanced Other Networks information','Enhanced Other Networks information';...
'Defined in RBDS (Fast switching information)','Fast switching information'; };

pty_list={...
'Undefined','Undefined';...
'News','News';...
'Current affairs','Information';...
'Information','Sports';...
'Sport','Talk';...
'Education','Rock';...
'Drama','Classic Rock';...
'Culture','Adult Hits';...
'Science','Soft Rock';...
'Varied','Top 40';...
'Pop Music','Country';...
'Rock Music','Oldies';...
'M.O.R. Music','Soft';...
'Light classical','Nostalgia';...
'Serious classical','Jazz';...
'Other Music','Classical';...
'Weather','Rhythm and Blues';...
'Finance','Soft Rhythm and Blues';...
'Children’s programmes','Language';...
'Social Affairs','Religious Music';...
'Religion','Religious Talk';...
'Phone In','Personality';...
'Travel','Public';...
'Leisure','College';...
'Jazz Music','Unassigned';...
'Country Music','Unassigned';...
'National Music','Unassigned';...
'Oldies Music','Unassigned';...
'Folk Music','Unassigned';...
'Documentary','Weather';...
'Alarm Test','Emergency Test';...
'Alarm','Emergency';...
};

group =char(ones(4,16)*35); % group = ############################ ...

L = length(data);

status=1; ini=1;  ok =[0 0 0 0];

while((ini+25)<=L)
 % fprintf('ini %d. Status %d\n',ini,status);  
  res = detect(ini,data,check); ini=ini+26;     
  
  switch (status)        
    case 1,  % searching for A block      
       if (res==offset(1)), 
          ok(1)=1;          
          group(status,:)=  char(48+data(ini-26+[0:15]));
          status=2; 
          fprintf(' A block found. ');
       else ini=ini-25; fprintf('*******\n FAILED CHK DETECTION*******\n'); 
       end                                      
    case 2,  % search for B block    
       if (res==offset(2)), ok(2)=1; 
         group(status,:)=  char(48+data(ini-26+[0:15]));
         fprintf(' B block found. ');
       end 
       status=3;        
    case 3,  % search for Ca or Cb block      
       if ( (res==offset(3) ) || (res==offset(4) )) 
          group(status,:)=  char(48+data(ini-26+[0:15]));
          ok(3)=1; 
          fprintf(' C block found. ');
       end
       status=4;       
    case 4,  % check D block. End of group.     
       if ( res==offset(5) ) 
          ok(4)=1;
          fprintf(' D block found. ');
          group(status,:)=  char(48+data(ini-26+[0:15]));
          fprintf('\n Encontrado grupo [%d%d%d%d]. Bits: (%d -> %d)\n',ok,ini-4*26,ini-1);         
          decode_group(group,ok);
          pause(0.5);
       end  
    
       ok=[0 0 0 0];      
       group =char(ones(4,16)*35);
       status=1;        
   end    
end


function result = detect(ini, data, check)
result = 0;
for k = 1:26
   if data(ini+k-1), result = bitxor(result, check(k)); end
end

function decode_group(group,ok)

global type_names pty_list radio_text program_name



if (sum(ok)<4), fprintf('**********\n Bad group *******\n'); return; end

% Block 1
fprintf('Country %d\n',bin2dec(group(1,1:4)));  % Country

fprintf('Grupo: %s\n',group');
type = bin2dec(group(2,1:4)); ver = group(2,5)-48;
pty = bin2dec(group(2,7:11));
%keyboard
fprintf('Grupo %d Ver %c -> %s\n',type,65+ver,char(type_names(type+1,ver+1)));
fprintf('PTY %s\n',char(pty_list(pty,1)));

ext_type = type*2+ver;

switch (ext_type)
   
    case 0,  % 0A type
        seg = bin2dec(group(2,15:16));
        pos = seg*2+[1:2];
        data = reshape(group(4,:),8,2)';
        program_name(pos)=char(bin2dec(data));
        %fprintf('SEG %d -> Data %c%c\n',seg,bin2dec(data));
        fprintf('Station %s\n',program_name);
        
        af = [bin2dec(group(3,1:8)) bin2dec(group(3,9:16))];
        fprintf('AFs %d %d\n',af);
        
    case 1,      
    
    case 4, % 2A radioText
       
       segment = bin2dec(group(2,13:16));
       pos = segment*4+[1:4];
       data = reshape([group(3,:) group(4,:)],8,4)';
       radio_text(pos)=char(bin2dec(data));
       fprintf('TEXT: %s\n',radio_text);
                            
    case 5,  % 2B RadioText
       segment = bin2dec(group(2,13:16));
       pos = segment*2+[1:2];
       data = reshape(group(4,:),8,2)';
       radio_text(pos)=char(bin2dec(data)); 
end    

