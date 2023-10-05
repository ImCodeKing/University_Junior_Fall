%% parameter setting of a rimless wheel
% 运行前请确定RLW的所有文件在当前运行的目录！！！
close all;  
clc;

% Specifies the number of spokes
Nspk = 7;       % number of the spoke(5~10)
Nwt = 2;        % number of additional weight(2,4,6)

% 基础的RimlessWheel的所有参数，
par.M = 1.034;          % gram
par.I = 0.0030452;      % meter.m^2  (inertia) （基础8辐的RimlessWheel）
par.L = 0.11;           % meter （The length of the spoke）
par.Phi = 2*pi/Nspk;    % radian (The Angle between the spokes)
par.g = 9.8;            % meter/sec^2 (gravity acceleration)
par.Gamma = -pi/10;     % radian (angle of the slope)

% 配重
Wt.M = 0.18*Nwt;
Wt.I = 0.00002503*Nwt;

% 给基础RimlessWheel增加配重,得到最终的机器人
par.M = par.M + Wt.M;
par.I = par.I + Wt.I;

%% find a fixed point
close all;  
clc;

% Guess an initial state
s0 = [ par.Phi/2-par.Gamma; -pi/1.25];    %[angle; angluar velocity]
t0 = 0;

% Options for fsolve
options = optimset('TolFun',1e-12,'TolX',1e-12,'LargeScale','off','MaxFunEvals',20); 

% find a fixed point
s_fp = fsolve(@(s) Step(s,0,par)-s,s0,options)

% walk 5 steps with s_fp as the initial state
% data store all informations during the walking, in order to animate it later 
[s_end, t_end, data] = Walk(s_fp, t0, par,5);

% animate the walking
Animation(data, par, 2);

%% walking 20 steps with a specified inial state 
close all;
clc;

% Speicify an initial states
theta0 = par.Phi/2-par.Gamma;;
theta_d0 = -sqrt( 2*par.M*par.g*par.L*(1-cos(par.Phi/2+par.Gamma) )/(par.M*par.L^2+2*par.I) );

s0 = [theta0; theta_d0];
t0 = 0;

% Take 10 steps. 
[s_end, t_end, data] = Walk(s0, t0, par,20);
Animation(data, par, 2);
% 这个例子是一个初始速度过小，能量不足的情况，因此形成不了极限环。

%% walking 20 steps with another specified inial state
close all;
clc;

% Initial Conditions
s0 = [par.Phi/2-par.Gamma; -6*pi/8];
t0 = 0;

% Take 10 steps. 
[s_end, t_end, data] = Walk(s0, t0, par,20);
Animation(data, par, 2);
% 这个例子是初始速度较大，但最终能收敛到稳定极限环的情况。
% 对于8个辐的RimlessWheel，初速度是足够大的，
% 但对于7个辐的RimlessWheel，初速度仍较小，仍需要加大。
