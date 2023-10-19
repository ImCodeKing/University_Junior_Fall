function [s_end, t_end, data] = Step(s0, t0, par)
% Step  Simulation of a single step of a simple dynamic biped.
%   [s_end, t_end, data] = Step(s0, t0, par) simulates one step starting from
%   the initial state s0 at time t0. Input par is structure with the
%   parameters of the model (par.L, par.R, par.m, par.I, par.B, par.C,
%   par.gamma, par.g). The function outputs the state at the end of the step
%   s_end at time t_end and a data log. The data log is a structure that
%   consists of the following fields: data.s and data.t (state and time data
%   during the step), data.posfoot (position of the stance foot during the
%   step) and data.event ('none', 'fall' or 'timeup').
%
%   See also: WALK, ANIMATION, DERIVEEOM

% simulation settings
abs_tol = 1e-12;         % Absolute error tolerances
max_time = 5;            % Max simulation time (s)
time_step = 1e-3;        % Output time step (s)

% initialize variables
data.event = 'none';
options = odeset('Events', @EventDetection, 'AbsTol', abs_tol);
tspan = t0: time_step: t0+max_time;

%%% START SIMULATION
%%% Continuous dynamics
[t_new,s_new,not_used,not_used,events] = ode45(@EOM,tspan,s0,options,par);

% update data logs
data.t = t_new;          % time log
data.s = s_new;          % state log
t_end = t_new(end);      % current time
s_end = s_new(end,:)';   % current state
data.posfoot = zeros(size(data.t));  % relative foot position is zero during the step

% check ouput
if t_end==(t0+max_time)
    data.event = 'timeup';
    s_end = NaN*ones(4,1);
    disp('STEP: Time is up. Increase max_time in Step.m')
    return
elseif events(end)~=1
    data.event = 'fall';
    s_end = NaN*ones(4,1);
    disp('STEP: Walker fall down')
    return
end

%%% Impact dynamics
[t_new,s_new] = Impact(t_end,s_end,par);

% update data log
data.t = [data.t; t_new];
data.s = [data.s; s_new'];
t_end = t_new;
s_end = s_new;

% determine new foot position (used in the animation)
phi_sw = s_end(2);
posfoot = -2*par.R*phi_sw-2*(par.L-par.R)*sin(phi_sw);
data.posfoot(end+1) = posfoot;

%% Function EOM - Equations of Motion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function s_dot = EOM(t,s,par)
% EOM determines the derivative of the state s
% unpack the state vector
phi_st = s(1);      % angle of the stance leg
phi_sw = s(2);      % angle of the swing leg
phi_st_d = s(3);    % angular rate of the stance leg
phi_sw_d = s(4);    % angular rate of the swing leg

%--------------------------------------------------------------------------
% partial derivatives of model coordinates to the generalized coordinates
J_st = [...
	- par.R - par.C*cos(phi_st) - par.B*sin(phi_st) - cos(phi_st)*(par.L - par.R),  	                                      0;
	          par.B*cos(phi_st) - par.C*sin(phi_st) - sin(phi_st)*(par.L - par.R),  	                                      0;
	                                                                            1,  	                                      0;
	                                        - par.R - cos(phi_st)*(par.L - par.R),  	- par.C*cos(phi_sw) - par.B*sin(phi_sw);
	                                                 -sin(phi_st)*(par.L - par.R),  	  par.B*cos(phi_sw) - par.C*sin(phi_sw);
	                                                                            0,  	                                      1  ];

% corriolis terms
D = [...
	             phi_st_d^2*(par.C*sin(phi_st) - par.B*cos(phi_st) + sin(phi_st)*(par.L - par.R));
	            -phi_st_d^2*(par.C*cos(phi_st) + par.B*sin(phi_st) + cos(phi_st)*(par.L - par.R));
	                                                                                            0;
	  phi_st_d^2*sin(phi_st)*(par.L - par.R) - phi_sw_d^2*(par.B*cos(phi_sw) - par.C*sin(phi_sw));
	(- par.C*cos(phi_sw) - par.B*sin(phi_sw))*phi_sw_d^2 - cos(phi_st)*(par.L - par.R)*phi_st_d^2;
	                                                                                            0  ];
                                                                     
% mass matrix
M = diag([par.m, par.m, par.I, par.m, par.m, par.I]);

% reduced mass matrix
Mr = J_st.'*M*J_st;

%--------------------------------------------------------------------------
% forces on the COM
% gravity force
f = par.m*[sin(par.gamma); -cos(par.gamma); 0; sin(par.gamma); -cos(par.gamma); 0]*par.g;

% elastic force
pos_h = [-par.R*phi_st - (par.L-par.R)*sin(phi_st)
         par.R         + (par.L-par.R)*cos(phi_st) ];
     
x_st = pos_h + RotationMatrix(phi_st)*[par.eB; par.eC];                       
x_sw = pos_h + RotationMatrix(phi_sw)*[par.eB; par.eC];
x = x_sw-x_st;
nx = norm(x);
d = sqrt(nx^2+par.A^2);

f_st = par.K*(d-par.A)*x/d;
f_sw = -f_st;

% elastic torque
com_st = pos_h + RotationMatrix(phi_st)*[par.B; par.C];                       
com_sw = pos_h + RotationMatrix(phi_sw)*[par.B; par.C];

d = com_st-x_st;    
d = [d(2),d(1)]; 
t_st = d*f_st;

d = com_sw-x_sw;
d = [d(2),d(1)];
t_sw = d*f_sw;

% vector with external forces
f = f + [f_st; t_st; f_sw; t_sw];

% friction forces
phi_d = phi_st_d-phi_sw_d;
fr_st =  -par.hF*phi_d;
fr_sw =  -fr_st;

f = f + [0; 0; fr_st; 0; 0; fr_sw];

%--------------------------------------------------------------------------
% reduced force vector
rhs = J_st.'*f  - J_st.'*M*D;

% solve to get the accelerations
udot = Mr\rhs;

% derivative is the combination of the velocities and the accelerations
s_dot = [phi_st_d; phi_sw_d; udot];

%% Function Event Detection %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [value, isterminal, direction] = EventDetection (t,s,par)
% EventDetection detects when the swing foot hits the ground or if the
% biped falls.

% unpack the state vector
phi_st = s(1);      % angle of the stance leg
phi_sw = s(2);      % angle of the swing leg

% swing foot hits the ground when (phi_st + phi_sw) is zero
value(1) = phi_st + phi_sw;

% to prevent heel scuffing the simulation is only stop if the stance leg
% is past vertical 
isterminal(1) = 0;
if phi_st < 0 
  isterminal(1) = 1; % stop
else
  isterminal(1) = 0; % don't stop
end
direction(1) = -1; % only negative crossings

% detection of a forward fall
value(2) = phi_st + pi/2;
direction(2) = -1;
isterminal(2) = 1;

% detection of a backward fall
value(3) = phi_st - pi/2;
direction(3) =  1;
isterminal(3) = 1;

%% Function Impact %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [t,s_plus] = Impact(t,s_minus,par)
% Impact determines the state (s_plus) after the impact based on the state
% (s_minus) before the impact.

% unpack the state vector
phi_st = s_minus(1);      % angle of the stance leg
phi_sw = s_minus(2);      % angle of the swing leg
phi_st_d = s_minus(3);    % angular rate of the stance leg
phi_sw_d = s_minus(4);    % angular rate of the swing leg

% partial derivatives of model coordinates to the generalized coordinates
% with the assumption that the STANCE foot is in contact with the floor
J_st = [...
	- par.R - par.C*cos(phi_st) - par.B*sin(phi_st) - cos(phi_st)*(par.L - par.R),  	                                      0;
	          par.B*cos(phi_st) - par.C*sin(phi_st) - sin(phi_st)*(par.L - par.R),  	                                      0;
	                                                                            1,  	                                      0;
	                                        - par.R - cos(phi_st)*(par.L - par.R),  	- par.C*cos(phi_sw) - par.B*sin(phi_sw);
	                                                 -sin(phi_st)*(par.L - par.R),  	  par.B*cos(phi_sw) - par.C*sin(phi_sw);
	                                                                            0,  	                                      1  ];
                                                                                                                              
% partial derivatives of model coordinates to the generalized coordinates
% with the assumption that the SWING foot is in contact with the floor
J_sw = [...
	- par.C*cos(phi_st) - par.B*sin(phi_st),  	                                        - par.R - cos(phi_sw)*(par.L - par.R);
	  par.B*cos(phi_st) - par.C*sin(phi_st),  	                                                 -sin(phi_sw)*(par.L - par.R);
	                                      1,  	                                                                            0;
	                                      0,  	- par.R - par.C*cos(phi_sw) - par.B*sin(phi_sw) - cos(phi_sw)*(par.L - par.R);
	                                      0,  	          par.B*cos(phi_sw) - par.C*sin(phi_sw) - sin(phi_sw)*(par.L - par.R);
	                                      0,  	                                                                            1  ];

% mass matrix
M = diag([par.m, par.m, par.I, par.m, par.m, par.I]);

% reduced mass matrix
Mr = J_sw.'*M*J_sw;

% x-, y-, and phi velocities of the CoM, before the impact
x_d = J_st*[phi_st_d; phi_sw_d];

% momentum before the impact
rhs = J_sw.'*M*x_d;

% solve impact equations to get the velocities after the impact
solution = Mr\rhs;

% state after the impact (note legs are switched here)
s_plus = [phi_sw; 
          phi_st; 
          solution(2);
          solution(1)];