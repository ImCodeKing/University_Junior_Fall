function [s_end, t_end, data] = Walk(s0, t0, par, nr_steps)
% Walk  Simulation of multipal steps of a rimless wheel. 
%   [s_end, t_end, data] = Walk(s0, t0, par, nr_steps) has the same inputs
%   and outputs as Step besides the input nr_steps. The input nr_steps
%   determines how many times the function Step is called. For more
%   information about the other inputs and outputs see Step.
%
%   See also: STEP, ANIMATION, ENERGYPLOT

% Mingguo Zhao,
% Robotics and Control Lab, Dept. of Au, Tsinghua Univ. May 2010
% Created for Robot Control Experiment 2010 Fall
% Modified based on Dynamic Walking2009's tutorial program

% initialize variables
s = s0;             % current state
t = t0;             % current time
data.s = [];        % state log
data.t = [];        % time log
data.s_end = [];    % end states of each step log
data.t_end = [];    % end times of each step log
data.posfoot = [];  % position foot log
prev_pos_foot = 0;  % position foot during previous step

% simulate steps
for n = 1:nr_steps
    % one step
    [s,t,datanew] = Step(s,t,par);
    
    % update logs
    data.s = [data.s; datanew.s];               % append data.s
    data.t = [data.t; datanew.t];               % and data.t
    data.s_end = [data.s_end; data.s(end,:)];   % append data.s_end
    data.t_end = [data.t_end; data.t(end)];     % and data.t_end
    
    cur_posfoot = datanew.posfoot+prev_pos_foot;    % equal size automatically
    data.posfoot = [data.posfoot; cur_posfoot]; 	% append data.posfoot
    prev_pos_foot = data.posfoot(end);              % update prev_posfoot
    
    if strcmp(datanew.event,'Stop') || strcmp(datanew.event,'timeup')
        break;
    end
end

% final state, time and event
s_end = data.s(end,:);
t_end = data.t(end);
data.event = datanew.event;

% display result 
%fprintf('WALK: walker walked %i step(s) and ended with event ''%s''\n',n,data.event)