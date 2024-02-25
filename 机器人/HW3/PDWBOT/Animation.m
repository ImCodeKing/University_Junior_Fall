function Animation(data,par,speed)
%   Animation shows an animation of a simple dynamic biped. 
%   Call Animation(data,par) after Step or Walk to display an animation. If
%   par.mm is non-zero the additional mass is shown. The speed of the
%   animation can be adjusted with Animation(data,par,speed). The default
%   value for speed is 1.
%
%   See also: STEP, WALK

%% Prameters
saveFigs = 0;   %saveFigs = 1;
legInColor    = [.4 .4 .5];
legOutColor   = [.85 .2 .2];
legShaftColor = [.4 .4 .5];
EPotColor   = [0 1 .2];
EKinColor   = [0.1 0.2 0.8];
EElaColor   = [1 0.5 1];
ETotColor   = [1 .4 .5];

HW = 15;        % hip width
HH = 10;        % hip high
LW = 30;        % half leg width
shaftR = 3;     % shaft radius 
L = par.L;      % Leg length
R = par.R;      % foot radius

%% Phase Figure Ojects 
% Determine which foot is the stance leg at any time
% 1 to begin, then 2, then 1...  
% Algorithm: 
% find jumps in the "posfoot" (0000000100000010000001000000...); 
% do a cumulative sum (0000000111111122222223333333...), 
% then use modulus 2 (00000001111111000000011111110000000...) 
% and add one (1111111222222211111112222222...)   
stanceFoot = [0; mod( cumsum( logical(diff(data.posfoot)) ), 2)] + 1; 

for n = 1:length(data.t)
    switch stanceFoot(n)
        case 1
            angIn(n,1) = data.s(n,1);
            angOut(n,1) = data.s(n,2);
            angInDot(n,:) = data.s(n,3);
            angOutDot(n,:) = data.s(n,4);
        case 2
            angIn(n,1) = data.s(n,2);
            angOut(n,1) = data.s(n,1);
            angInDot(n,:) = data.s(n,4);
            angOutDot(n,:) = data.s(n,3);
    end
end

phaseFig = figure;
set(phaseFig,'Position',[10    460   500   400]);
PhaseAxesHandle = axes('Parent',phaseFig); 

hold on;
PhaseLnInHandle   = plot(angIn,angInDot,   'Parent', PhaseAxesHandle, 'Color', legInColor, 'LineWidth', 1);
PhasePtInOHandle  = plot(NaN,NaN,          'Parent', PhaseAxesHandle, 'Color', legInColor, 'MarkerFaceColor', legInColor, 'Marker','p');
PhasePtInHandle   = plot(NaN,NaN,          'Parent', PhaseAxesHandle, 'Color', legInColor, 'MarkerFaceColor', legInColor, 'Marker','o');
PhaseLnOutHandle  = plot(angOut,angOutDot, 'Parent', PhaseAxesHandle, 'Color', legOutColor, 'LineWidth', 1);
PhasePtOutOHandle = plot(NaN,NaN,          'Parent', PhaseAxesHandle, 'Color', legOutColor, 'MarkerFaceColor', legOutColor, 'Marker','p');
PhasePtOutHandle  = plot(NaN,NaN,          'Parent', PhaseAxesHandle, 'Color', legOutColor, 'MarkerFaceColor', legOutColor, 'Marker','o');

drawnow;
set(PhaseAxesHandle,'XLimMode','manual','YLimMode','manual','ZLimMode','manual')
title('Phase Plot');xlabel({'Angle (rad)'}); ylabel({'Angular Rate (rad/sec)'}); 
legend('LegIn','legOut','Location','Best', 'Location', 'SouthWest');

%% Animation Figure,Axes,Normal Legs and Slope
% normal legs
Alfa = asin(LW/R);          % foot angle
L = L-R*(1-cos(Alfa));      % drawing leg length witout the foot
Iy = -L+R*cos(Alfa);        % foot arc center
A = linspace(Alfa, -Alfa, 12);  % 12 foot arc points
B = linspace(0,2*pi,12);        % 12 shaft points

legInX = [HW  LW        LW,...
          0.6*LW    0.6*LW  -0.6*LW -0.6*LW 0.6*LW  LW,...
          R*sin(A),...
          -LW  -LW     -1.4*LW  -HW -HW];
legInY = [HH  -0.475*L  -L,...
          -0.96*L   -0.55*L -0.65*L -0.96*L -0.96*L -L, ...
          Iy-R*cos(A),...
          -L   -0.5*L  -0.125*L -HH HH];
legInZ = -0.5*ones(size(legInX));

legOutX = [0.96*HW    LW        LW,...
           0.6*LW    0.6*LW  -0.6*LW -0.6*LW 0.6*LW LW,...
           R*sin(A),...
           -LW  -LW     -1.4*LW  -HW -HW];
legOutY = [1.5*HH  -0.475*L  -L,...
           -0.96*L   -0.55*L -0.65*L -0.96*L -0.96*L -L,...
           Iy-R*cos(A),...
           -L   -0.5*L  -0.125*L -HH  1.5*HH];
       
legShaftX = shaftR*cos(B);
legShaftY = shaftR*sin(B);
legShaftZ = 0.1*ones(size(legShaftX));

% Calculate hip position
data.hippos = zeros(length(data.t),2);
for n = 1:length(data.t)
    data.hippos(n,:) = [-par.R*data.s(n,1) - (par.L-par.R)*sin(data.s(n,1))   % x- position of Hip
                         par.R             + (par.L-par.R)*cos(data.s(n,1))]; % y-position of Hip
                       
    data.hippos(n,:) = data.hippos(n,:) + [data.posfoot(n), 0];  % translate the Hip according to the ground contact point
end

% Size of Animation window
min_x = min(data.hippos(:,1))-par.L;
max_x = max(data.hippos(:,1))+par.L;
min_y = -par.L/2;
max_y = max(data.hippos(:,2))+par.L/2;

width_x = max_x-min_x;
width_y = max_y-min_y;
size_xy = 2.5;

if width_x/size_xy > width_y
    min_y = min_y-(width_x/size_xy - width_y)/2;
    max_y = max_y+(width_x/size_xy - width_y)/2;
else
    min_x = min_x-(width_y*size_xy - width_x)/2;
    max_x = max_x+(width_y*size_xy - width_x)/2;
end

% create objects
animationFig = figure;  
set(animationFig, 'Position',[10    50   1000   320]);
AxesHandle = axes('Parent',animationFig,  'Position',[0 0 1 1]);
set(AxesHandle,'Ylim',[min_y max_y],'Xlim',[min_x max_x]);

FloorHandle = patch('Parent',AxesHandle,  'EdgeColor',[0 0 0], 'LineWidth',1, 'FaceColor',[.1 .1 1], 'FaceAlpha', 0.20);
LegInHandle = patch(legInX,legInY,legInZ,legInColor);
LegOutHandle = patch(legOutX,legOutY,legOutColor, 'FaceAlpha',.9);
LegShaftHandle = patch(legShaftX,legShaftY,legShaftZ,legShaftColor);

axis off;
axis equal;

%% Energy Plot
energyFig = figure;
set(energyFig,'Position',[530    460  480   400]);
EnergyAxesHandle = axes('Parent',energyFig); 

% initialize variables
I = size(data.s,1);
Ekin = NaN*ones(I,1);
Epot = NaN*ones(I,1);
Eela = NaN*ones(I,1);

for i = 1:I
    % unpack the state vector
    phi_st   = data.s(i,1);
    phi_sw   = data.s(i,2);
    phi_st_d = data.s(i,3);
    phi_sw_d = data.s(i,4);
    
    % calculate the position of the CoMs
    pos_h = [-par.R*phi_st - (par.L-par.R)*sin(phi_st)
             par.R         + (par.L-par.R)*cos(phi_st)];
    pos_h = pos_h + [data.posfoot(i);0];
    
    x = [ pos_h + RotationMatrix(phi_st)*[par.B; par.C]    % x- and y position of CoM of the stance leg 
          phi_st                                            % angle of CoM of the stance leg 
          pos_h + RotationMatrix(phi_sw)*[par.B; par.C]    % x- and y position of CoM of the swing leg 
          phi_sw                                ];          % angle of CoM of the swing leg    
    
    % calculate the velocities of the CoMs
    J_st = [...
	- par.R - par.C*cos(phi_st) - par.B*sin(phi_st) - cos(phi_st)*(par.L - par.R),  	                                      0;
	          par.B*cos(phi_st) - par.C*sin(phi_st) - sin(phi_st)*(par.L - par.R),  	                                      0;
	                                                                            1,  	                                      0;
	                                        - par.R - cos(phi_st)*(par.L - par.R),  	- par.C*cos(phi_sw) - par.B*sin(phi_sw);
	                                                 -sin(phi_st)*(par.L - par.R),  	  par.B*cos(phi_sw) - par.C*sin(phi_sw);
	                                                                            0,  	                                      1  ];
    
    xd = J_st*[phi_st_d; phi_sw_d];
    
    % mass matrix
    M = diag([par.m, par.m, par.I, par.m, par.m, par.I]);
    
    % gravity vector
    f = [sin(par.gamma);-cos(par.gamma);0;sin(par.gamma);-cos(par.gamma);0];
    
    % kinetic energy
    Ekin(i) = 0.5*xd'*M*xd;
    
    % potential energy
    Epot(i) = -x'*M*f*par.g;
    
    % Elastic energy
    phi = phi_sw-phi_st;
    Xst = pos_h + RotationMatrix(phi_st)*[par.eB; par.eC];
    Xsw = pos_h + RotationMatrix(phi_sw)*[par.eB; par.eC];
    Dis = sqrt(norm(Xsw-Xst)^2+par.A^2);
    Eela(i) = 0.5*par.K*(Dis-par.A)^2;
end

% zero potential energy with the first position
Epot = Epot-Epot(1);
Epot = Epot*1e-9;
Ekin = Ekin*1e-9;
Eela = Eela*1e-9;
Etot = (Ekin+Epot+Eela);

hold on;
PEnergyHandle = plot(data.t,Epot,   'Parent',EnergyAxesHandle,'Color',EPotColor,'LineWidth',1); 
KEnergyHandle = plot(data.t,Ekin,   'Parent',EnergyAxesHandle,'Color',EKinColor,'LineWidth',1);
EEnergyHandle = plot(data.t,Eela,   'Parent',EnergyAxesHandle,'Color',EElaColor,'LineWidth',1);
TEnergyHandle = plot(data.t,Etot,   'Parent',EnergyAxesHandle,'Color',ETotColor,'LineWidth',1);

PEnergyPHandle = plot(NaN,NaN,      'Parent',EnergyAxesHandle,'Color',EPotColor,'MarkerFaceColor',EPotColor,'Marker','p'); 
KEnergyPHandle = plot(NaN,NaN,      'Parent',EnergyAxesHandle,'Color',EKinColor,'MarkerFaceColor',EKinColor,'Marker','o');
EEnergyPHandle = plot(NaN,NaN,      'Parent',EnergyAxesHandle,'Color',EElaColor,'MarkerFaceColor',EElaColor,'Marker','o');
TEnergyPHandle = plot(NaN,NaN,      'Parent',EnergyAxesHandle,'Color',ETotColor,'MarkerFaceColor',ETotColor,'Marker','s');

drawnow;
set(EnergyAxesHandle,'XLimMode','manual','YLimMode','manual','ZLimMode','manual')
xlabel({'Time (s)'}); ylabel({'Energy (J)'}); title('Energy Plot');
set(EnergyAxesHandle,'Xlim',[min(data.t) max(data.t)],'Ylim',[min(Epot) max(Ekin)]);
legend('Epot','Ekin','Eelastic','Etot','Location','Best');

%% Animation 
SaveNum = 0; % counter for frame number; used if outputting graphics

% Speed control
if nargin<3; speed = 1; end     % default speed
dt = data.t(2)-data.t(1);       % step time of simulation
nom_cycle_time = 0.02;          % 50 fps nominal for external animations. 
frameNum = ceil(nom_cycle_time/dt*speed);

% floor
step_len = (max_x - min_x) / 6
floor_pos = [min_x, min_x, min_x+step_len, min_x+step_len, min_x+2*step_len, min_x+2*step_len,min_x+3*step_len, min_x+3*step_len, min_x+4*step_len, min_x+4*step_len, min_x+5*step_len, min_x+5*step_len, max_x, max_x; 
             -10,     0,        0,              10,             10,                30,             30,                50,               50,               80,              80,                110,         110,  -10];
% floor_pos = [min_x, min_x, max_x, max_x; 
%              -10,   0,     0,     -10  ];
floor_pos = RotationMatrix(-par.gamma)*floor_pos; % rotate coordinate system with sloop 
set(FloorHandle,'Xdata',floor_pos(1,:),'Ydata',floor_pos(2,:));

% Legs
tic     % start timer

% show legs and phase of each frame data
for n = 1:frameNum:length(data.t) 
    % state variables
    phiIn = angIn(n);
    phiOut = angOut(n);

    
    % leg In
    legInPos = RotationMatrix(phiIn)*[legInX;legInY];       % rotate leg to correct angle
    legInPos(1,:) = legInPos(1,:) + data.hippos(n,1);       % add hip offset (x-direction)
    legInPos(2,:) = legInPos(2,:) + data.hippos(n,2) + 60;       % add hip offset (y-direction)
    legInPos = RotationMatrix(-par.gamma)*legInPos;         % rotate coordinate system with sloop
    set(LegInHandle,'Xdata',legInPos(1,:),'Ydata',legInPos(2,:));
        
    % leg Out
    legOutpos = RotationMatrix(phiOut)*[legOutX;legOutY]; 
    legOutpos(1,:) = legOutpos(1,:) + data.hippos(n,1);   
    legOutpos(2,:) = legOutpos(2,:) + data.hippos(n,2) + 60;   
    legOutpos = RotationMatrix(-par.gamma)*legOutpos;     
    set(LegOutHandle,'Xdata',legOutpos(1,:),'Ydata',legOutpos(2,:)); 
    
    % shaft
    legShaftpos = RotationMatrix(phiIn)*[legShaftX;legShaftY]; 
    legShaftpos(1,:) = legShaftpos(1,:) + data.hippos(n,1);    
    legShaftpos(2,:) = legShaftpos(2,:) + data.hippos(n,2) + 60;   
    legShaftpos = RotationMatrix(-par.gamma)*legShaftpos;     
    set(LegShaftHandle,'Xdata',legShaftpos(1,:),'Ydata',legShaftpos(2,:)); 
   
    % Phase Graph
    set(PhaseLnInHandle,'XData',angIn(1:n),'YData',angInDot(1:n));
    set(PhasePtInOHandle,'XData',angIn(1),'YData',angInDot(1));
    set(PhasePtInHandle,'XData',angIn(n),'YData',angInDot(n));
    set(PhaseLnOutHandle,'XData',angOut(1:n),'YData',angOutDot(1:n));
    set(PhasePtOutOHandle,'XData',angOut(1),'YData',angOutDot(1));
    set(PhasePtOutHandle,'XData',angOut(n),'YData',angOutDot(n));
        
        
    % Energy Graph
    set(PEnergyHandle,'XData',data.t(1:n),'YData',Epot(1:n));
    set(KEnergyHandle,'XData',data.t(1:n),'YData',Ekin(1:n));
    set(TEnergyHandle,'XData',data.t(1:n),'YData',Etot(1:n));
    
    set(PEnergyPHandle,'XData',data.t(n),'YData',Epot(n));
    set(KEnergyPHandle,'XData',data.t(n),'YData',Ekin(n));
    set(TEnergyPHandle,'XData',data.t(n),'YData',Etot(n));
    
    drawnow;
    
    % speed control
    while toc<(data.t(n)/speed)
        1+1;        % waste time
    end 
    
     if saveFigs
        set([animationFig],'RendererMode','manual','Renderer','painters')
        set([animationFig, phaseFig],'PaperPosition',[0 0 8 4.2],'PaperSize',[20 12])
        print(animationFig,'-dtiff','-r300', sprintf('PDWBOT3D%03d', SaveNum) )
 %       print(phasefig,'-dtiff',     sprintf('PDWBOTphase%03d', SaveNum) )
         SaveNum =  SaveNum + 1;
    end
 end

pause(1);
FramesPerSecond = 1/(frameNum*dt)
end  % end of main Animation function