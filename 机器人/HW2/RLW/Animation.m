function Animation(data,par,speed)
%% Settings
% animation colors
spoke_color =  [0.25,   0.25,   0.25];  % normal spoke color
stance_color = [0.9,    0,      0];     % stance spoke color
slope_color =   [0.1,   0.1,    1];     % slope color

% constant
spoke = [0; -par.L];            % corrdinates of the stance spoke
spoke_number = 2*pi/par.Phi;    % number of the spokes

% spoke matrix
spoke_wheel = [];               % matrix of each spoke 
for i = 1:spoke_number
    spoke_wheel = [ spoke_wheel, RotationMatrix(par.Phi*(i-1))*spoke ]; 
end;

% length of the slope
margin = 1.25*2*par.L;
long = data.posfoot(end) + 2*margin;

%% objects used for animation
height = 1024 * ((abs(long*sin(par.Gamma)) + 2*par.L)/long*cos(par.Gamma));

scale = 1;
if height>300 
    scale = 300/height;
    long = long*scale;
    height = height*scale;
end
angle = data.s(:,1);
angle_d = data.s(:,2);


% -------------------------------------------------------------------------
% animation graph
animationfig = figure;
AxesHandle = axes('Parent', animationfig,  'Position',[0 0 1 1]);    % full

% figures width and height
set(animationfig,'Position',[10   2*height+250   1024*scale   height]);

% slope handle and settings
SlopeHandle = patch('Parent',AxesHandle,... 
                    'LineWidth',2,...
                    'EdgeColor',slope_color,...
                    'EdgeAlpha', 0.30,...
                    'FaceColor',slope_color,...
                    'FaceAlpha', 0.30);
                
% set figure's axis limit            
floor_pos = [-margin, data.posfoot(end) + margin;
             0,             0 ];                    % floor matrix,[x1,x2;y1,y2]        
floor_pos = RotationMatrix(par.Gamma)*floor_pos;    % rotate the floor by slope

min_x = min(floor_pos(1,:));
min_y = min(floor_pos(2,:));
max_x = max(floor_pos(1,:));
max_y = max(floor_pos(2,:) + 2*par.L);               

set(AxesHandle, 'Xlim',[min_x max_x],...            
                'Ylim',[min_y max_y]);                

% spokes handle and settings 
SpokeHandle = cell(spoke_number,1);
SpokeHandle{1,1} = line('Parent',AxesHandle,... 
                        'Color',stance_color,...
                        'LineWidth',2);             % stance spoke
for i = 2:spoke_number
    SpokeHandle{i,1} = line('Parent',AxesHandle,...
                            'Color',spoke_color,...
                            'LineWidth',2);         % other spokes
end

% draw the slope           
set(SlopeHandle,'Xdata',[floor_pos(1,:),floor_pos(1,1)],...
                'Ydata',[floor_pos(2,:),floor_pos(2,2)]);

% draw the impact point
hold on;
impact_pos = RotationMatrix(par.Gamma)*[data.posfoot';...
                                        zeros(size(data.posfoot))'];
for i = 1: max(size(data.posfoot))-1
   if data.posfoot(i+1)~= data.posfoot(i)
       plot(impact_pos(1,i),impact_pos(2,i),'ro');
   end 
end
plot(impact_pos(1,end),impact_pos(2,end),'ro');


% -------------------------------------------------------------------------
% data graph
datafig = figure;  
DataAxesHandle = axes('Parent',datafig); 
set(datafig,'Position',[10    50   1024*scale   height]);
plot(data.t,data.s);

DataLnHandle = plot(data.t,angle,...
                        'Parent',DataAxesHandle,...
                        'Color','r',...
                        'LineWidth',1);    
hold on;
                    
DataPtHandle = plot(NaN,NaN,'Parent',DataAxesHandle,...
                             'Color','r',...
                             'Marker','p');
                         
DataLnHandle_d = plot(data.t,angle_d,...
                        'Parent',DataAxesHandle,...
                        'Color','b',...
                        'LineWidth',1);    
hold on;
                    
DataPtHandle_d = plot(NaN,NaN,'Parent',DataAxesHandle,...
                             'Color','b',...
                             'Marker','p');
drawnow;

xlabel({'Time (s)'}); 
ylabel({'Angle&Angular Rate','(rad)(rad/sec)'}); 
title('Data Plot'); 
legend('Angle','Angular Rate');
grid
% -------------------------------------------------------------------------
% phase figure
phasefig = figure; 
PhaseAxesHandle = axes('Parent',phasefig); 
set(phasefig,'Position',[10    height+80    1024*scale   height]);
                   
min_x = min(data.s(:,1));
min_y = min(data.s(:,2));
max_x = max(data.s(:,1));
max_y = max(data.s(:,2));
margin = max( (max_x-min_x),(max_y-min_y))/20;
plot(data.s(:,1),data.s(:,2));
axis equal;

PhaseLnHandle = plot(angle,angle_d,...
                        'Parent',PhaseAxesHandle,...
                        'Color','r',...
                        'LineWidth',1);    hold on;
                    
PhasePtHandle = plot(NaN,NaN,'Parent',PhaseAxesHandle,...
                             'Color','b',...
                             'Marker','p');
drawnow;

xlabel({'Angle (rad)'}); 
ylabel({'Angular Rate (rad/sec)'}); 
title('Phase Plot');  
grid



% -------------------------------------------------------------------------
% speed control
if nargin<3; 
    speed = 1;                              % default speed 
end         

dt = data.t(2)-data.t(1);
nom_cycle_time = 0.03;                      % about 33fps             
interval = ceil(nom_cycle_time*speed/dt);   % normal time interval

% shaft position
shaft_pos = zeros(2,max(size(data.t)));     % clear the shaft position matrix

% doing the animation
for i= 1:interval: size(data.t)
    % shaft pose matrix
    shaft_pos(:,i) = RotationMatrix(data.s(i,1))*[0;par.L] + [data.posfoot(i);0];   % matrix of shaft in level
    shaft_pos_slope(:,i) = RotationMatrix(par.Gamma)*shaft_pos(:,i);                % rotated by slope
 
    % shopke pose matrix
    spoke_pos = RotationMatrix(data.s(i,1)) * spoke_wheel;                          % spokes matrix to the shaft in level
    for n=1:spoke_number
        spoke_pos(:,n) = spoke_pos(:,n) + shaft_pos(:,i);                           % spokes matrix to the origin in slope                        
        spoke_pos(:,n) = RotationMatrix(par.Gamma)*spoke_pos(:,n);                  % spokes matrix to the origin in the level
        % draw a spoke form shaft to the spoke
        set(SpokeHandle{n,1},'XDATA',[shaft_pos_slope(1,i), spoke_pos(1,n)],...     % draw spoks [X_shaft(n), X_spoke(n)
                             'YDATA',[shaft_pos_slope(2,i), spoke_pos(2,n)]);       %             Y_shaft(n), Y_spoke(n)]
    end
    
    % draw the pahse graph
    set(PhaseAxesHandle, 'Xlim',[min_x-margin max_x+margin],...            
                         'Ylim',[min_y-margin max_y+margin]);
    set(PhaseLnHandle,'XData',angle(1:i),'YData',angle_d(1:i));
    set(PhasePtHandle,'XData',angle(i),'YData',angle_d(i));
    axis equal;
     
    % draw the data graph
    set(DataAxesHandle, 'Xlim',[0 data.t(end)],...            
                         'Ylim',[min(min(angle),min(angle_d)) max(max(angle),max(angle_d))]);
                     
    set(DataLnHandle,'XData',data.t(1:i),'YData',angle(1:i));
    set(DataPtHandle,'XData',data.t(i),'YData',angle(i));

    set(DataLnHandle_d,'XData',data.t(1:i),'YData',angle_d(1:i));
    set(DataPtHandle_d,'XData',data.t(i),'YData',angle_d(i));
    
   
    drawnow;
end

