par.M = 1;          % g
par.R = 0.2         % m
par.L = 1;          % m
par.Phi = pi/4;     % radian
par.g= 1;        	% m/sec^2
par.Gamma = -pi/20  % radian

%% find a fixed point
close all;  clc;

%Initial Conditions
s0 = [ par.Phi/2; -pi/1.25];
t0 = 0;

options = optimset('TolFun',1e-12,'TolX',1e-12,'LargeScale','off','MaxFunEvals',20);%Options for fsolve
s_fp = fsolve(@(s) Step(s,0,par)-s,s0,options)

[s_end, t_end, data] = Walk(s_fp, t0, par,5);
Animation(data, par, 1);


%% walking 20 steps with an inial state 
clc
close all

%Initial Conditions
theta0 = par.Phi/2;
theta_d0 = -sqrt( (2*par.g*par.L*(1-cos(par.Phi/2+par.Gamma)))/(par.L^2+2*par.R^2) );

s0 = [theta0; theta_d0];
t0 = 0;

% Take 10 steps. 
[s_end, t_end, data] = Walk(s0, t0, par,20);
Animation(data, par, 1);

%%
close all;
clc;

%Initial Conditions
s0 = [-pi/3; pi/3];
t0 = 0;

% Take 10 steps. 
[s_end, t_end, data] = Walk(s0, t0, par,20);
Animation(data, par, 1);
