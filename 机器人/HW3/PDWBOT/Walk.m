function [s_end, t_end, data] = Walk(s0, t0, par, nr_steps)
% Walk  Simulation of multipal steps of a simple dynamic biped. 
%   [s_end, t_end, data] = Walk(s0, t0, par, nr_steps) has the same inputs
%   and outputs as Step besides the input nr_steps. The input nr_steps
%   determines how many times the function Step is called. For more
%   information about the other inputs and outputs see Step.
%
%   See also: STEP, ANIMATION, ENERGYPLOT

% initialize variables
s = s0;             % current state
t = t0;             % current time
data.s = [];        % state log
data.t = [];        % time log
data.s_end = [];    % end states log
data.t_end = [];    % end times log
data.posfoot = [];  % position foot log
prev_pos_foot = 0;  % position foot during previous step

% simulate steps
for n=1:nr_steps
    % one step
    [s,t,datanew] = Step(s,t,par);
    
    % update logs
    data.s = [data.s; datanew.s];
    data.t = [data.t; datanew.t];
    data.s_end = [data.s_end; data.s(end,:)];
    data.t_end = [data.t_end; data.t(end)];
    data.posfoot = [data.posfoot; datanew.posfoot+prev_pos_foot];
    prev_pos_foot = data.posfoot(end);
    
    % break if the biped falls
    if strcmp(datanew.event,'fall') || strcmp(datanew.event,'timeup')
        break;
    end
end

% final state, time and event
s_end = data.s(end,:);
t_end = data.t(end);
data.event = datanew.event;

% display result 
% fprintf('WALK: walker walked %i step(s) and ended with event ''%s''\n',n,data.event)