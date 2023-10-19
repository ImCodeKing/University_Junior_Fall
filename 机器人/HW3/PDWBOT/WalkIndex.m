function [AvgSpeed, AvgStepLen] = WalkIndex(data)
%Caculate the average speed and step length of the simulation results,
% data is the results of the simulation.
%
%See also: SetEnvironment.m, SetWeightPar.m,

n = length(data.t);
AvgSpeed = data.posfoot(n)./data.t(n);
AvgStepLen = data.posfoot(n)./sum(logical(diff(data.posfoot)));