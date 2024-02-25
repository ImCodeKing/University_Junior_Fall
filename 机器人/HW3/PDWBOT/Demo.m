%% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Robot 2023 Fall
% Demonstration of THUDA PDWBOT Simulation
%
% See also Step.m, Walk.m, Animation.m, Stability.m etc.

%% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Robot and Environment Setting
clc;            % clear main window
close all;      % close other windows
clear all;      % clear workspace

PDWBot = SetLegPar(180, 50, 210, 8.16e5, -2.3, -67);            % SetLegPar(L,R,m,I,B,C)
PDWBot = SetEnvironment(PDWBot, 0.025, 9806);                   % SetEnvironment(Robot, Slope, Gravity)
Wt = SetWeightPar(50, 5e-1, 0, -70);                            % SetWeightPar(m,I,B,C)
NewBot = AddWeight(PDWBot, Wt);                                 % AddWeight(oldBot,Weight)
NewBot = AddElastic(NewBot, 50, NewBot.B, NewBot.C, 0.08e6);    % AddElastic(oldBot,A,eB,eC,K)

options = optimset('TolFun', 1e-12, ...
                   'TolX', 1e-12, ...
                   'LargeScale', 'off', ...
                   'MaxFunEvals', 100);                  % Options for fsolve
               
%% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Examples of Step Function
clc; close all;

% Initial Conditions 
s0 = [0.225; -0.225; -2.0; -1.0];       
t0 = 0;

% Take a step
[s_end, t_end, data] = Step(s0, t0, NewBot) % [s_end, t_end, data] = Step(s0, t0, par)
Animation(data, NewBot, 1);                 % 1 is the relative speed of the animation (1 ~ real time)

% Note: the Phase Plot, Energy Plot and the Animation Plot, ... ...

%% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Examples of Walk Function_Stable
clc; close all;

% Initial Conditions
s0 = [0.417001; -0.417001; -3.538098; -0.816115];
t0 = 0;

% Take 10 steps 
[s_end, t_end, data] = Walk(s0, t0, NewBot, 20); %[s_end, t_end, data] = Walk(s0, t0, par, nr_steps) 
                                                 % Walk.m function calls Step.m 10 times
% Show results
Animation(data, NewBot, 1); 	

% Note: the Phase Plot, ... ...

%% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Examples of Walk Function_fall down
clc; close all;

% Initial Conditions 
s0 = [0.225; -0.225; -2.95; -1.5];       
t0 = 0;

% Take some steps
[s_end, t_end, data] = Walk(s0, t0, NewBot, 10); 
Animation(data, NewBot, 1);

% Note: the swing leg(red) swing to fast! Or the stance leg swing to slow!

%% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Examples of Find a fixed point
clc; close all;

% Guess the Initial Conditions
s_guess = [0.417001; -0.417001; -3.538098; -0.816115];
t0 = 0;

% find a fixed point using fsolve
s_fp = fsolve(@(s) Step(s, 0, NewBot)-s, s_guess, options)    % Matlab function, using help fsolve to see details 
                                                              % Find the
                                                              % root of f(s)=Step(s)-s
% walk from the 'fixed point'
[s_end, t_end, data] = Walk(s_fp, t0, NewBot, 5);       

% Show some results
Animation(data, NewBot, 1);  

% Note: the Limit Cycle in the Phase Plot, ... ... 

%% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Examples of Stability
clc; close all

% Guess the Initial Conditions
s_guess = [0.225; -0.225; -2.0; -1.0];
t0 = 0;
 
% find a fixed point using fsolve 
s_fp = fsolve(@(s) Step(s, 0, NewBot)-s, s_guess, options)  
 
% eignvalue of the FixedPoint's Jacobian Matrix
[d,v] = Stability(NewBot, s_fp)
pause;  % Note the Eignvalues and Eignvectors

% walk some steps with a very little p ertribution of 10%00
[s_end, t_end, data] = Walk(s_fp*1.001, t0, NewBot, 35); 

% Show some results
Animation(data, NewBot, 2);  
pause;
% Note the PhasePlot and the attraction of the cycle

% Show the final cycle
[s_end, t_end, data] = Walk(s_fp, t0, NewBot,6); 
Animation(data, NewBot, 1); 

%% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Example of Bifurcation
clc; close all

% Initial Conditions 
s0 = [0.225; -0.225; -2.0; -1.0];        
t0 = 0;

% Take 20 steps 
[s_end, t_end, data] = Walk(s0, t0, PDWBot, 20); 

% Show some results
Animation(data,PDWBot,2); 
% Note there 2 attraction cycles of InnerLeg and Out Leg respectively

pause;
% Show the final period-2 cycle
[s_end, t_end, data] = Walk(s_end, t0, PDWBot, 6);
Animation(data,PDWBot,2); 

%% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Period-1 Stability is NOT working, Period-2 is used as a cycle??
clc; close all;

% Guess the Initial Conditions
s_guess = [0.225; -0.225; -2.0; -1.0];
t0 = 0;

% Period-I stability
s_fp = fsolve(@(s) Step(s, 0, PDWBot)-s, s_guess, options)  
[d,v] = Stability( PDWBot, s_fp)
pause;

% Period-II stability_I 
clc;
s_fp1 = fsolve(@(s)  Walk(s, 0, PDWBot, 2)-s, s_end, options)
[d,v] = StabilityW( PDWBot, s_fp1, 2) 
pause;

% Period-II stability_II 
clc;
[s_end, t_end, data] = Walk(s_end, t0, PDWBot, 1);
s_fp2 = fsolve(@(s)  Walk(s, 0, PDWBot, 2)-s, s_end, options)
[d,v] = StabilityW( PDWBot, s_fp2, 2)
pause; 

% Show the 3 Fixed Points
clc;
[s_fp'; s_fp1; s_fp2]

% Note: the 2,3 line of the FixedPoint Matrix

%% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Examples of WalkIndex Function
clc; close all;

% Initial Conditions
s0 = [0.225; -0.225; -2.5; -1.5];
t0 = 0;

% Take 10 steps 
[s_end, t_end, data] = Walk(s0, t0, NewBot, 2); %[s_end, t_end, data] = Walk(s0, t0, par, nr_steps) 
                                                 % Walk.m function calls Step.m 10 times
% Average Speed and Step length                                                  
[AvgSpeed, AvgStepLeng] = WalkIndex(data)        % mm/s, mm

% Show results
Animation(data, NewBot, 2); 	
