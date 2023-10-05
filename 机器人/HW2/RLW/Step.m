function [s_end, t_end, data] = Step(s0, t0, par)
% Step  Simulation of a single step of a simple dynamic biped.
%   [s_end, t_end, data] = Step(s0, t0, par) simulates one step starting from
%   the initial state s0 at time t0. Input par is structure with the
%   parameters of the model (par.L,par.m, par.I, par.gamma, par.g, par.Phi).
%   The function outputs the state at the end of the step
%   s_end at time t_end and a data log. The data log is a structure that
%   consists of the following fields: data.s and data.t (state and time data
%   during the step), data.posfoot (position of the stance foot during the
%   step) and data.event ('none', 'Forward Impact', 'Backward Impact' or 'Timeup').
%
%   See also: WALK, ANIMATION, ENERGYPLOT, DERIVEEOM

% Mingguo Zhao,
% Robotics and Control Lab, Dept. of Automation, Tsinghua University. May 2010

% simulation settings
abs_tol = 1e-15;         % Absolute error tolerances
max_time = 50;           % Max simulation time (s)
time_step = 0.0005       % Output time step (s)

% initialize variables
data.event = 'none';                  % Clear the event
tspan = t0: time_step: t0+max_time;   % Simulation Time

if s0(1)>1.05*par.Phi/2 
    s0(1) = par.Phi/2;
    disp('STEP: Inproper State. S0(1) is changed to the Maxium value Phi/2');
elseif s0(1)<-1.05*par.Phi/2
    s0(1) = -par.Phi/2;
    disp('STEP: Inproper State. S0(1) is changed to the Maxium value -Phi/2');
end


% Set ODE's option with EventDetection function and tolerance
options = odeset('Events', @EventDetection, 'AbsTol', 1e-15);    

% START SIMULATION -------------------------------------------------------------------- 
% Continuous dynamics
[t_new, s_new, not_used, not_used, events] = ode45(@EOM,tspan,s0,options,par);

% update data logs
data.t = t_new;             % time log
data.s = s_new;             % state log
t_end = t_new(end);       % current time
s_end = s_new(end,:)';   % current state
data.posfoot = zeros(size(data.t));  % relative foot position is zero during the step

% check ouput
if t_end==(t0+max_time)
    data.event = 'Timeup';
    s_end = NaN*ones(2,1);
    disp('STEP: Time is up. Increase max_time in Step.m');
    return
elseif (events(end) == 1)
    data.event = 'Forward Impact';
    disp('STEP: Rimless Wheel get a Forward Impact')
    
    if abs(s_end(2)^2) < abs_tol
        data.event = 'Stop';
        disp('STEP: No Energy, Stopped');
        return
    end
elseif (events(end) == 2)
    data.event = 'Backward Impact';
    disp('STEP: Rimless Wheel get a Backward Impact');
    
     if abs(s_end(2)^2)<abs_tol
        data.event = 'Stop';
        disp('No Energy, Stopped');
        return
    end
end


% Impact dynamics
[t_new,s_new] = Impact(t_end,s_end,par);

% update data logs
data.t = [data.t; t_new];
data.s = [data.s; s_new'];
t_end = t_new;
s_end = s_new;

% determine new foot position(used in the animation)
posfoot = 2*par.L*sin(s_end(1));
data.posfoot(end+1) = posfoot;

%%%% END of Simulation ----------------------------------------------------

%% Function EOM - Equations of Motion %%%%%%%%%%%%%%%
function s_dot = EOM(t,s,par)
% EOM determines the derivative of the state s
% unpack the state vector
theta = s(1);      % angle and 
theta_d = s(2);    % angular rate of the stance spoke

% solve to get the accelerations
udot = (par.L*par.g*par.M*sin(par.Gamma+theta))/(par.M*par.L^2+par.I);

% derivative is the combination of the velocities and the accelerations
s_dot = [theta_d; udot];

%% Function Event Detection %%%%%%%%%%%%%%%%%%%
function [value, isterminal, direction] = EventDetection(t,s,par)
% unpack the state vector
theta = s(1);      % angle of the stance leg
theta_d = s(2);    

% detection of a forward imapct
value(1) = 2*theta + par.Phi;
direction(1) = -1; % only negative crossings
isterminal(1) = 1; % stop

% detection of a backward impact
value(2) = 2*theta - par.Phi;
direction(2) = 1;
isterminal(2) = 1;

%% Function Impact
function [t,s_plus] = Impact(t,s_minus,par)
% Impact determines the state (s_plus) after the impact based on the state
% (s_minus) before the impact. 

% unpack the state vector
theta = s_minus(1);      % angle and
theta_d = s_minus(2);    % angular rate of the stance spoke

% solve impact equations to get the velocities after the impact
phi = -sign(theta)*par.Phi; % not usefull here, for cos(phi)>0
solution = (par.M*par.L^2*cos(phi) + par.I)/( par.M*par.L^2 + par.I)*theta_d;

% state after the impact (note legs are switched here)
s_plus = [-theta; 
          solution];
   
      
%% End of Step.m 